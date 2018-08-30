import datetime

from flask import Blueprint, request, session, current_app, send_from_directory
from sqlalchemy.sql.expression import func
from geojson import FeatureCollection, Feature
from geoalchemy2.shape import to_shape

from geonature.utils.utilssqlalchemy import json_resp, to_json_resp, to_csv_resp
from geonature.utils.env import DB, ROOT_DIR
from .models import TInfoSite, TVisiteSFT, corVisitPerturbation, CorVisitGrid, Taxonomie, ExportVisits
from .repositories import check_user_cruved_visit
from geonature.core.gn_monitoring.models import corVisitObserver, TBaseVisits, TBaseSites, corSiteApplication, corSiteArea
from geonature.core.ref_geo.models import LAreas

from pypnnomenclature.models import TNomenclatures, BibNomenclaturesTypes
from pypnusershub.db.tools import (
    InsufficientRightsError,
    get_or_fetch_user_cruved,
)
from geonature.utils.utilsgeometry import(
    ShapeService
)
from pypnusershub import routes as fnauth

from geonature.core.users.models import TRoles, BibOrganismes

blueprint = Blueprint('pr_suivi_flore_territoire', __name__)
#  toutes les routes se trouvent dans ce fichier ayant le préfixe suivi_flore_territoire
# Pourquoi: C' dans le fichier server.py 
# (qui est dans GeoNature, puis backend/geonature/server.py) = fichier pour le démarrage de l'application,
# que ceci a été défini. 
#  Dans la partie if with_external_mods: url_prefix=conf['api_url']
#  et donc dans gn_module_suivi_flore_territoire
#  dans le fichier conf_gn_module.toml: api_url = '/suivi_flore_territoire'
#  c' pour ça que quand on met blueprint.route('/sites') par exemple,
#  on sait bien que l'on doit aller sur 127.0.0.1:8000/suivi_flore_territoires/sites
#  et donc c' pourquoi cette route (que l'on récupère dans DataService) "sait" sur quelle fonction qu'elle doit s'appuyer

@blueprint.route('/sites', methods=['GET'])
# ceci est la méthode GET des requêtes clients. Ca fait parti des requêtes HTTP
# --> HTTP : HyperText Transfert Protocol, est un protocole de communication client-serveur. 
#     Il est utilisé pour échanger toute sorte de données entre client HTTP et serveur HTTP. 
#     Les requêtes vont toujours par paires: la demande (du client) et la réponse (du serveur). 
# --> La syntaxe de la demande (requête client) est toujours la même: 
            # Ligne de commande (Commande, URL, Version de protocole)
            # En-tête de requête
            # <nouvelle ligne>
            # Corps de requête
#      Ex: GET /suivi_flore_territoire/sites?id_base_site=2 HTTP/1.1" 200 
#     --> Ligne de commande 
#           + Commande = est méthode à utiliser, il spécifie le type de requête, donc ici c' GET
#             Méthode GET: méthode la plus courante pour demander une ressource. Cette méthode est sans effet sur la ressource, 
#             il doit être possible répéter la requête sans effet. 
#           + URL: l'adresse de la page sur le serveur. C' le '/suivi_flore_territoire/sites?id_base_site=2'
#             Ca veut dire la route sites se trouve dans suivi_flore_territoire qui se situe à la racine du serveur. 
#           + La version HTTP utilisée:  HTTP/1.1
# --> Les réponses ont, elles aussi, toujours la même syntaxe: 
            # Ligne de statut (Version, Code-réponse, Texte-réponse)
            # En-tête de réponse
            # <nouvelle ligne>
            # Corps de réponse
#     Ex: 127.0.0.1 - - [27/Aug/2018 10:48:21]  "GET /suivi_flore_territoire/sites HTTP/1.1" 200
#     + En tête = Date: 27/Aug/2018 10:48:21
#     + Code réponse: 200 (tt va bien)
#  Conclusion: HTTP n'est pas un langage mais un proocole de communication. 
#  On l'utilise via un langage de programation (ici c' le python). 
#  Le langage se chargera de se connecter au serveur, d'envoyer/ recevoir les requêtes et de fermer la connexion. 
#  Pour faire des requêtes HTTP et recevoir les réponses du serveur, il faut utiliser les sockets (ah oui d'accord encore un autre délire.... )


@json_resp
def get_sites_zp():
    '''
    Retourne la liste des ZP
    '''
    parameters = request.args 
    # le request.args est une méthode de Flask.
    #  l'objet request représente la requête exécutée par le client. 
    #  request.args renvoie un dictionnaire contenant les paramètres présents dans l'URL (les trucs derrières ?param1=qcc&param2=qqc). 
    #  donc ici on met dans parameters ce dictionnaire 
   
    q = (
        DB.session.query(
            TInfoSite,
            func.max(TBaseVisits.visit_date),
            Taxonomie.nom_complet,
            func.count(TBaseVisits.id_base_visit)
        ).join(
            TBaseVisits, TBaseVisits.id_base_site == TInfoSite.id_base_site
        ).join(
            Taxonomie, TInfoSite.cd_nom == Taxonomie.cd_nom)
        .group_by(TInfoSite, Taxonomie.nom_complet)
    )


    # la requête est produite en termes d'une session donnée.
    # Le DB.session.query ici est la source de toutes les instructions SELECT générées par l'ORM.  
    # (ORM = type de programme en informatique, qui se place en interface entre un programme applicatif
    # et une BD relationnelle pour simuler une base de donnée orientée objet. 
    # Ce programme définit des correspondances entre les schémas de la BD et les classes du programme appplicatif.
    # Blah blah rien compris, mais là une explication bcp plus facile à comprendre: 
    # "C' une technique de programmation faisant le lein entre le monde de la base de données et le monde de programmation objet.
    # Elle permet de transformer une table en un objet facilement manipulable via ses attributs." Voilà voilàaaaa c' ça!!)
    # DONC SQLAlChemy est un ORM ok compris!!!!!.
    # En gros c' toutes les instructions SELECT que l'on peut faire sur la table TInfoSite (qui se trouve dans le models.py).

    # on Select TInfoSite, max des dates dans TBaseVisit(pour avoir la dernière date), le nom du cd nom, 
    # et la longueur du colonne id_base_visit (pour savoir ya cb de visites)
    # on fait la jointure avec la table TBaseVisits (pour avoir ) les visit_date, 
    # puis fait la jointure avec la table Taxonimie pour avoir le nom du cd nom
    #  finalement on Group by car on a utilisé une fonction sur un groupe de résultat. 
    #  On Group By les autres groupes de résultats qui ne sont pas obtenus par fonctions 
   
   
    if 'id_base_site' in parameters:
    #  si on peut trouver id_base_site dans l'URL
        q = q.filter(TInfoSite.id_base_site == parameters['id_base_site'])
    # q.filter = appliquer le critère de filtrage donné à une copie de cette requête, en utilisant des expressions SQL.
    #  ici ça veut dire Select * where TInfoSite.id_base_site = id_base_site se trouve dans parameters (URL)
    if 'id_application' in parameters:
        q = q.join(
            corSiteApplication, corSiteApplication.c.id_base_site == TInfoSite.id_base_site
        ).filter(corSiteApplication.c.id_application == parameters['id_application'])
    
    # print(q)
    print(current_app.config)
    data = q.all()
    # on met dans data la liste des résultats de q
    # q.all() est une méthode de sqlalchemy 
    # il renvoie un tableau contenant tous les résultats de la requête 
    features = []
    for d in data:
        print (d)
        feature = d[0].get_geofeature()
        # je déclare la variable feature, je mets dedans le 1er élément de mon d (position 0)
        # puis j'utilise la méthode get_geofeature pour obtenir les coordonnées géographiques de ce site. 
        feature['properties']['date_max'] = str(d[1])
        # dans la propriété 'proprieties' de ce tableau, je crée la propriété date max. 
        feature['properties']['nom_taxon'] = str(d[2])
        #  pareil, toujours dans la propriété 'propreties', je crée la propriété nom_taxon
        feature['properties']['nb_visit'] = str(d[3])
        #  et puis nb_visit = nombre de visites sur ce site. 
        features.append(feature)
        # je add dans le tableau features
    return FeatureCollection(features)
    #  puis je retourne un FeatureCollection
    #  c' un objet, 2 propriétés: features (qui est un tableau), et type = FeatureCollection 

  
    # return FeatureCollection([d.get_geofeature() for d in data])

@blueprint.route('/site', methods=['GET'])
@json_resp
def get_one_zp():
    '''
    Retourne une ZP à partir de l'id_base_site
    param:
        id_base_site: integer
    '''
    parameters = request.args
    q = DB.session.query(TInfoSite)
    if 'id_base_site' in parameters:
        q = q.filter(TInfoSite.id_base_site == parameters['id_base_site'])
    data = q.first()

    #  je prend le 1er résultat et je met dans data;
    #  c' pour ça que quand je vais sur la route http://127.0.0.1:8000/suivi_flore_territoire/site
    #  ça donne le premier résultat de la table TInfoSite, ça veut dire la ligne avec le id_base_site= 2 et id_info_site = 6
    if data:
    #  si ya data 
        return data.as_dict()
    # On trouve la méthode as_dict dans geonature.utils.utilssqlalchemy;
    # cette méthode permet de convertir data (ligne de la table corrrespondante) en dictionnaire 
    # ({nom: nom; age: age} etc) que supporte le format Json.
    return None


@blueprint.route('/site/<id_infos_site>', methods=['GET'])
@json_resp
def get_one_zp_id(id_infos_site):
    '''
    Retourne une ZP à partir de l'id_info_site
    '''
    data = DB.session.query(TInfoSite).get(id_infos_site)
    # la méthode .get() renvoie une instance basée sur l'identifiant de la clé primaire passée en paramètre.
    # vu que id_infos_sites est la clé primaire de la table TInfoSite
    # on veut Select * de la ligne qui porte cette id_infos_site 
    return data.as_dict()




@blueprint.route('/visits', methods=['GET'])
@json_resp
def get_visits():
    '''
    Retourne toutes les visites du module
    '''
    parameters = request.args
    q = DB.session.query(TVisiteSFT)
    if 'id_base_site' in parameters:
        q = q.filter(TVisiteSFT.id_base_site == parameters['id_base_site'])
    data = q.all()
    # return data.as_dict()
    return [d.as_dict(True) for d in data]
    
    # on doit mettre as_dict(True) ici car on veut que d prend aussi des valeurs des tables "relationship"
    # (voir dans models.py). 
    # ça donne la même chose si on écrit [d.as_dict(recursif=True) for d in data]
    # on itère sur chaque l'objet de data, puis on le met dans un tableau 
    # vu que c' toutes les visites, on doit les mettre dans un tableau

    # En d'autres termes, la ligne  return [d.as_dict(True) for d in data] peut être écrit, 
    # de manière plus compréhensive, sous "format" suivant: 
    # mydata = []
    # for d in dat:
    #     mydata.append(d.as_dict(True))
    # return mydata


@blueprint.route('/test', methods=['GET'])
@json_resp
def test():
    data = DB.session.query(TNomenclatures).all()
    return [d.as_dict(True) for d in data]

    
@blueprint.route('/visit/<id_visit>', methods=['GET'])
@json_resp
def get_visit(id_visit):
    '''
    Retourne une visite
    '''
    data = DB.session.query(TVisiteSFT).get(id_visit)
    return data.as_dict(recursif=True)
    #  vu qu'ici c'une visite seulement, on met une ligne data.as_dict(True)
    # contrairement au tableau des visits ci-dessus


@blueprint.route('/visit', methods=['POST'])
@fnauth.check_auth_cruved('C', True)
@json_resp
def post_visit(info_role):
    # on a mis info_role pour check le droit de l'utilisateur 
    # print("mes roles ", info_role)
    data = dict(request.get_json())
    # cast en dict le (request.get_json())
    tab_perturbation = data.pop('cor_visit_perturbation')   
    # on enlève la colonne 'cor_visit_perturbation' dans data et le met dans tab_perturbation 
    # pareil pour cor_visit_grid et cor_visit_observer.
    tab_visit_grid = data.pop('cor_visit_grid')
    tab_observer = data.pop('cor_visit_observer')
    visit = TVisiteSFT(**data)
    # le ** ici = copie tous les data dans TVisitSFT et met dans visit??? 
    #  le data maintenant n'a donc plus de cor_visit_perturbation, cor_visit_grid et cor_visit_observer  
    # print(data)
    print(visit.as_dict(True))
    perturs = DB.session.query(TNomenclatures).filter(
        TNomenclatures.id_nomenclature.in_(tab_perturbation)).all()    
    # je déclare la variable perturs.
    #  je questionne la table TNomenclatures en appliquant le filtre where id_nomenclature dans cette table 
    #  = id_nomenclature dans la tab_perturbation.
    # puis je mets tous dans perturs. 

    for per in perturs:
        # j'itère sur chaque objet de perturs
        visit.cor_visit_perturbation.append(per)
        # je rajoute cet objet per dans visit.cor_visit_perturbation    
    for v in tab_visit_grid:
        visit_grid = CorVisitGrid(**v)
        # Dans la table CorVisitGrids, on veut tous les attributs        
        visit.cor_visit_grid.append(visit_grid)
        # Puis on rajoute cette ligne dans la table visit.cor_visit_grid 

    observers = DB.session.query(TRoles).filter(
        TRoles.id_role.in_(tab_observer)
        ).all()
        # on va d'abord interroger la table TRoles pour prend les lignes portant l'id_role dans TRoles qui est aussi dans (tab_observer)
        
    for o in observers:
        # print(o.as_dict())
        visit.observers.append(o)
    if visit.id_base_visit:
    # je vérifie dans visit s'il y en a déjà un id_base_visit. 
    # # si oui, 

        user_cruved = get_or_fetch_user_cruved(
            session=session,
            id_role=info_role.id_role,
            id_application_parent=current_app.config['ID_APPLICATION_GEONATURE']
        )
        #  cette fonction vérifie si le cruved est dans la session. 
        #  si ce n'est pas le cas, on prend le cruved depuis la base de donnéees. 
        #  cette fonction retourne un dictionnaire, avec la clé = action de cruved et la valeur associée = portée de cruved
        #  exemple: {'R': '3', 'C': '3', 'E': '3', 'D': '3', 'U': '3', 'V': '3'}.
        update_cruved = user_cruved['U']
        #  donc ici, on met dans update_cruved la valeur associée de la clé 'U' dans user_cruved 
        check_user_cruved_visit(info_role, visit, update_cruved)
        #  on appelle la méthode que l'on a déclarée dans repositories pour check les droits d'utilisateur
        DB.session.merge(visit)
        # si tout va bien, je fusionne les anciennes données et les nouvelles 
    else:    
        DB.session.add(visit)
    # si ya pas id_base_visit dans visit, ça veut dire c' un nouveau rajout
    #  donc je crée une nouvelle ligne         
    DB.session.commit()
    # on rajoute et on envoie au serveur pour qu'il rajoute dans pgAmin3

    return visit.as_dict(recursif=True)



@blueprint.route('/export_visit', methods=['GET'])
def export_visit():

    parameters = request.args

    export_format = parameters['export_format'] if 'export_format' in request.args else 'shapefile'
    # si on ne met rien, par défaut, on va télécharger sous format shapefile 
    file_name = datetime.datetime.now().strftime('%Y_%m_%d_%Hh%Mm%S')
    # calcule l'heure du moment où on télécharge le fichier. 
    q =  (DB.session.query(ExportVisits))

    if 'id_base_visit' in parameters:

        q = (DB.session.query(ExportVisits)
            .filter(ExportVisits.id_base_visit == parameters['id_base_visit'])
        )
    elif 'id_base_site' in parameters:
        q = (DB.session.query(ExportVisits)
            .filter(ExportVisits.id_base_site == parameters['id_base_site'])
        )
    
        
    data = q.all()
    features = []
    
    if export_format == 'geojson':
        #  si c' le format geojson 
        for d in data:
            feature = d.as_geofeature('geom', 'id_area', False)
        # cette méthode est définie dans geonature.utils.utilssqlalchemy
        # 1er parametre: coordonées géométrie, 2ème: sur quel 'unité' qu'on veut les données (id_base_site? id_area?),
        # 3ème paramètre: récursif ou pas. 
            features.append(feature)
        result = FeatureCollection(features)
        # puis je transforme ce tableau features --> FeatureCollection 

        return to_json_resp(
            result,
            as_file=True,
            filename=file_name,
            indent=4
    )
    #  cette méthode transforme résultat en fichier json
    # 5 paramètres:
    #   +result = résultat
    #   +status quand on télécharge : 200 si tt va bien 
    #   +fichier téléchargeable: true or false.
    #   +nom de fichier : qu'on a déclaré un peu plus haut. 
    #   +indentation dans fichier : 4. 

    elif export_format == 'csv':
    #  si c' format csv
        tab_visit = []

        for d in data:
            visit =  d.as_dict()
            #  transforme d en as_dict
            geom_wkt = to_shape(d.geom)
            # on transforme d.geom (actuellement format wkb) en wkt
            visit['geom'] = geom_wkt
            # puis on crée dans visit la propriété 'geom' pour mettre dedans geom_wkt
            
            tab_visit.append(visit)
            # on ajoute tous dans tab_visit
        
        return to_csv_resp(
            file_name,
            tab_visit,
            tab_visit[0].keys(),
            ';'

        )
        #  cette méthode prend 4 paramètre: nom de fichier, les données (ici c' tab_visit),
        #  les colonnes que l'on veut afficher. Ici dans tab_visit, tous les lignes ont les mêmes "clés" = nom de colonne
        #  on ne doit donc prendre que la 1ère ligne (1ère élément dans ce tableau et extraire les keys pour avoir toutes les colonnes) 
        #  Puis le dernier paramètre = séparateur. 
    
    else:
        print('LAAA')
       
        # #TODO: mettre en parametre le srid
        
        dir_path = str(ROOT_DIR / 'backend/static/shapefiles')
        # pour télécharger format shapefiles, ce fichier va être enregistré sur le serveur 
        #  ce pkoi on a ce path... (enfin j'espère que c' ça l'explication ... )
        ExportVisits.as_shape(
            geom_col='geom',
            dir_path=dir_path,
            srid=2154,
            data=data,
            file_name=file_name
        )
        # méthode transforme en shape: 
        # dans sqlalchemyutils, cette méthode prend 5 paramètres (dont 1 c' self, on peut omettre)
        # ici il faut avoir le srid=2154 car c' projection internationale alors que dans notre table ExportsVisits,
        # le srid=4326 (projection française). 
        # (db_cols doit va avec srid normalement, c' sur quelle colonne qu'on veut "extraire" les coordonées géographiques). 
        return send_from_directory(
            dir_path,
            file_name+'.zip',
            as_attachment=True
        )
    #  on envoie au serveur. 


@blueprint.route('/organisme', methods=['GET'])
@json_resp
def get_organisme():
    '''
    Retourne la liste des organismes
    '''
    parameters = request.args 

    q = DB.session.query(
        TVisiteSFT.id_base_visit, 
        TRoles.nom_role, 
        TRoles.prenom_role, 
        BibOrganismes.nom_organisme
        ).join(
        corVisitObserver, corVisitObserver.c.id_base_visit == TVisiteSFT.id_base_visit
        ).join(
        TRoles, TRoles.id_role == corVisitObserver.c.id_role
        ).join(
        BibOrganismes, BibOrganismes.id_organisme == TRoles.id_organisme
        )
        
    
    if 'id_base_site' in parameters:
        q = q.filter(TVisiteSFT.id_base_site == parameters['id_base_site'])

    data = q.all() 
    print(data)
    # return [d.as_dict(True) for d in data]
    features = []
    for d in data:
        feature = {}
        feature['id_base_visit'] = str(d[0])
        feature['observer'] = str(d[1]) + ' ' + str(d[2])
        feature['nom_organisme'] = str(d[3])
        features.append(feature)
    return FeatureCollection(features)
 
@blueprint.route('/info_zp/<id_base_site>', methods=['GET'])
@json_resp
def get_info_zp(id_base_site):
      '''
      Retourne la/les communes d'une ZP. 
      TODO: Intégrer cette partie dans routes.py de gn_monitoring 
      '''

      params = request.args


      q = DB.session.query(
         corSiteArea,
         LAreas.area_name,
      ).join(
         LAreas,
         LAreas.id_area == corSiteArea.c.id_area
      ).filter(
         corSiteArea.c.id_base_site == id_base_site
      ) 

      if 'id_area_type' in params:
         q = q.filter(LAreas.id_type == params['id_area_type'])
      
      data = q.all()
      print("mes data ", data )
      features = []
      for d in data:
         feature = dict()
         feature['id_base_site'] = str(d[0])
         feature['id_area'] = str(d[1])
         feature['area_name'] = []
         feature['area_name'].append(str(d[2]))
         # une ZP peut être se retrouver dans 2 communes différentes? 
         # si oui, comment ça se présente? 
         features.append(feature)
      return FeatureCollection(features)






