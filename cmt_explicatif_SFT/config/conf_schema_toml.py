'''
   Spécification du schéma toml des paramètres de configurations
'''

from marshmallow import Schema, fields
# mashmallow est un ORM pour convertir les données complexes en objet en Python
# (ou l'inverse) 
# Schema et fields sont les classes de marsmallow. 
#  - Schema: pour définir les schémas personnalisés.
#  - Fields: pour définir les différents types de données 
from geonature.utils.config_schema import GnModuleProdConf


available_export_format = ['geojson', 'csv', 'shapefile']

zp_message = {"emptyMessage": "Aucune zone à afficher ", "totalMessage": "zone(s) de prospection au total"}
list_visit_message = {"emptyMessage": "Aucune visite sur ce site ", "totalMessage": "visites au total"}


default_maplist_zp_columns = [
    {"name": 'Identifiant', "prop": 'id_base_site', "width": 90},
    {"name": 'Taxon', "prop": 'nom_taxon', "width": 350},
    {"name": 'Nombre de visites', "prop": 'nb_visit', "width": 120},
    {"name": 'Date de la dernière visite', "prop": 'date_max', "width": 160},
    {"name": 'Organisme', "prop": 'nom_organisme', "width": 200}
]

default_list_visit_columns = [
    {"name": 'Date', "prop": 'visit_date'},
    {"name": 'Observateur(s)', "prop": "observers"},
    {"name": 'Présence/ Absence ? ', "prop": "state"},

]

#  ce fichier est pour maj le fichier module.config.ts dans le frontend
# pour que ça marche, il faut tout déclarer les paramètres avant cette classe GnModulesSchema.
# ya toujours (je pense) une seule classe principale dans ce fichier, 
#  qui est chargée pour le maj du fichier module.config. Si on voit plusieurs classes dans ce fichier, 
#  c' forcément possible que ces classes sont des fiels.Nested de la classe principale, par ex:
#  class FormConfig(Schema):
    # releve = fields.Nested(ReleveFormConfig, missing=dict())
    # occurrence = fields.Nested(OccurrenceFormConfig, missing=dict())
    # counting = fields.Nested(CountingFormConfig, missing=dict())
#  puis dans GnModuleSchemaConf:
    # form_fields = fields.Nested(FormConfig, missing=dict())
# On appelle ça un fiels imbriqué.  
# On l'utilise pour représenter la relation, on passe la classe qu'on veut 'imbriquer' en paramètre. 
# On peut préciser également le field qu'on veut sur notre objet imbriqué en utilisant le 'only'
#  ex: # form_fields = fields.Nested(FormConfig, only=["releve"])


class GnModuleSchemaConf(GnModuleProdConf):
    zp_message = fields.Dict(missing=zp_message)
    # missing: valeur par défaut 
    list_visit_message = fields.Dict(missing=list_visit_message)
    export_available_format = fields.List(fields.String(), missing=available_export_format)
    default_zp_columns = fields.List(fields.Dict(), missing=default_maplist_zp_columns)
    default_list_visit_columns = fields.List(fields.Dict(), missing=default_list_visit_columns)
    id_type_maille = fields.Integer(missing=203)
    id_type_commune = fields.Integer(missing=101)
    id_menu_list_user = fields.Integer(missing=10)
