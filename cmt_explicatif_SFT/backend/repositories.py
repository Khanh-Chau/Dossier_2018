from flask import Blueprint, request, session, current_app

from geonature.utils.errors import InsufficientRightsError
from pypnusershub.db.tools import get_or_fetch_user_cruved

def check_user_cruved_visit(user, visit, cruved_level):
    #  cette fonction prend 3 parametres: 
    #  + role d'utilisateur (celui qui est en train de saisir les données )
    #  + une visite (TVisitSFT)
    #  + portée de cruved (entier: 1, 2 ou 3)
    """
    Check if user have right on a visit object, related to his cruved
    if not, raise 403 error
    """
    #  6 actions possibles dans Geonature: Create, Read, Update, Validate, Export, Delete. 
    # 3 portées de ces actions:
    #  + cruved_level 1 : J'ai droit de Cruved que mes données
    #  + cruvel_level 2 : J'ai droit de Cruved les données de mon organisme
    #  + cruved_level 3 : J'ai droit de cruved toutes les données (rôle d'admin par ex )
    
    is_allowed = False
    #  par défaut ce paramètre est false 
    if cruved_level == '1': 
        for role in visit.observers:
            if role.id_role == user.id_role:
                # si l'utilisateur (en train de saisir les données) est le même que celui dans cor_visit_observer de TVisitSFT
                print('même id ')
                is_allowed = True
                # on lui permet de cruved les données
                break
            elif role.id_role == visit.id_digitiser:
                # si non on vérifie si son rôle est le même que l'id_digitiser ayant été enregistré dans TVisitSFT
                #  id_digitiser: je saisi les données de qq1 d'autres pour lui. 
                is_allowed = True
                break
        if not is_allowed:
            raise InsufficientRightsError(
            ('User "{}" cannot update visit number {} ')
            .format(user.id_role, visit.id_base_visit),
            403
            )       
            # sinon, on lève une erreur: 
            # celle là utilise la méthode str.format() de python pour formattage de chaînes.
            # Les chaînes de formatage contiennent des "champs de remplacement " entourées d'accolades {}
            # Ici, la 1ère accolade est remplacé par user.id_role; et la 2ème est remplacé par visit.id_id_base_visit 
       
       
    elif cruved_level == '2':
         for role in visit.observers:
            if role.id_role == user.id_role:
                print('même role')
                is_allowed = True
                break
            elif role.id_role == visit.id_digitiser:
                is_allowed = True
                break
            elif role.id_organisme == user.id_organisme:
                # si l'organisme de celui en train de saisir les données est le même de celui ayant été enregistré dans la  BD
                is_allowed = True
                break
         if not is_allowed:
            raise InsufficientRightsError(
            ('User "{}" cannot update visit number {} ')
            .format(user.id_role, visit.id_base_visit),
            403
            )   
    
   