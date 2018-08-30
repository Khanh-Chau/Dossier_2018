import { Injectable, Inject } from "@angular/core";
import { HttpClient, HttpParams } from "@angular/common/http";
import { AppConfig } from "@geonature_config/app.config";
/*  ce fichier contient des routes dont on a besoin pour faire des appels au backend,
afin d'enregistrer ou charger les données, ou encore d'effectuer des calculs ou des modifs des données
que l'on ne souhaite pas faire faire par le frond end.  

Angular met à disposition un service appelé HttpClient qui permet de créer et d'exécuter des appels HTTPs
(fait par AJAX - Asynchronous JavaScript and XML) et de réagir aux informations retournées par le serveur. 
*/
@Injectable()
export class DataService {
  constructor(private _http: HttpClient) {}

  getZp(params?) {
    //  retourner toutes les ZP si sans param passé
    //  retourner une ZP spécifique en fonction du param passé

    /* params doit se présenter sous forme objet, par ex:
    params = {
      id_base_site: 5
    }  */

    let myParams = new HttpParams();
    /* HttpParams est le corps d'une requête/ réponse HTTP qui représente les paramètres sérialisés
      En gros il représente les paramètres passés dans les () des méthodes. 

    */

    for (let key in params) {
      myParams = myParams.set(key, params[key]);
    }
    /* 
    vu que params c' un objet, on itère sur cet objet
    La méthode set de myParams construit un nouveau corps de requête avec une nouvelle valeur pour le paramètre passé
    En gros il consruit un nouveau objet avec la clé est le paramètre qu'on veut passer.  
    On enregisre ça dans myParams.  
   */

    return this._http.get<any>(
      `${AppConfig.API_ENDPOINT}/suivi_flore_territoire/sites`,
      { params: myParams }
    );
    /*
    La méthode get() retourne un Observable, mais vu qu'ici on va recevoir des données, TypeScript a besoin de savoir de quel type elles seront. 
    On doit donc ajouter le <any> (ça veut dire n'importe quel type) pour dire qu'on reçoit n'importe quel type 
    (utilisé quand on n'est pas certaint du type car le type any permet d'autoriser tous les types )
    Après le get<any> c' la route sur laquelle on veut récupérer les données. 
  */
  }

  getMaille(id_base_site: number, params?: any) {
    // retourner toutes les mailles d'une ZP pour pouvoir afficher sur la carte
    //  le params? c' pour que dans le front end, on précise id_type_nomenclature = Mailles 25*25 (et pas commune par ex)
    let myParams = new HttpParams();

    for (let key in params) {
      myParams = myParams.set(key, params[key]);
    }
    return this._http.get<any>(
      `${AppConfig.API_ENDPOINT}/gn_monitoring/siteareas/${id_base_site}`,
      { params: myParams }
    );
  }

  getInfoSite(id_base_site) {
    // pour savoir sur chaque site, quel est l'espèce examinée (affiche cd_nom mais pas nom_taxon )
    return this._http.get<any>(
      `${
        AppConfig.API_ENDPOINT
      }/suivi_flore_territoire/site?id_base_site=${id_base_site}`
    );
  }

  postVisit(data: any) {
    // poster une nouvelle visite ou éditer une visite déjà existée
    console.log(data);
    console.log("déjà post ! ");

    return this._http.post<any>(
      `${AppConfig.API_ENDPOINT}/suivi_flore_territoire/visit`,
      data
    );
    /*
    On enregistre les données dans la base de données au endpoint suivi_flore_territoire/visit par la méthode post.
    La méthode post permet de lancer un appel POST, prend comme 1er argument l'URL visée 
    (ici ${AppConfig.API_ENDPOINT}/suivi_flore_territoire/visit),
    et 2ème argument ce qu'on doit envoyer à cer URL. 
    La méthode post retourne un Observable, c'ad elle ne fait pas appel à elle toute seule. C' en y souscrivant que l'appel est lancé. 
*/
  }

  getVisits(params: any) {
    //  retourne les visites en fonction du/des paramètre(s) passé(s).
    let myParams = new HttpParams();

    for (let key in params) {
      myParams = myParams.set(key, params[key]);
    }

    return this._http.get<any>(
      `${AppConfig.API_ENDPOINT}/suivi_flore_territoire/visits`,
      { params: myParams }
    );
  }

  getOneVisit(id_visit) {
    //  retourne une visite spécifique
    return this._http.get<any>(
      `${AppConfig.API_ENDPOINT}/suivi_flore_territoire/visit/${id_visit}`
    );
  }

  getOrganisme(params: any) {
    //  récupérer l'organime
    let myParams = new HttpParams();

    for (let key in params) {
      myParams = myParams.set(key, params[key]);
    }

    return this._http.get<any>(
      `${AppConfig.API_ENDPOINT}/suivi_flore_territoire/organisme`,
      { params: myParams }
    );
  }

  getCommune(id_base_site: number, params: any) {
    // récupérer le nom de commune
    let myParams = new HttpParams();

    for (let key in params) {
      myParams = myParams.set(key, params[key]);
    }

    return this._http.get<any>(
      `${
        AppConfig.API_ENDPOINT
      }/suivi_flore_territoire/info_zp/${id_base_site}`,
      { params: myParams }
    );
  }
}
