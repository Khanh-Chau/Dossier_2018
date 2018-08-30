/*
Ce fichier contient des étapes nécessaires pour qu'on puisse utiliser nos composants au sein de notre application.
Chaque application (ici notre application c' suivi_flore_territoire) possède au moins un module, c' le root module. (AppModule)
Ici, notre AppModule est gnModule.module.ts 
Un module Angular regroupe un ensemble de composants Angular dans une même unité logique. 
(ici notre module SFT (ce fichier là pour être exacte) contient plusieurs composants: detail-visit, form-visit )

ATTENTION: 
      + notre application SFR se figure dans GeoNature (en local) grâce au fichier frontend/src/app/routing/app-routing.module.ts  

      + Dans app-routing.module.ts qui se trouve dans GeoNature, ya: 
       export const routing = RouterModule.forRoot(defaultRoutes, {useHash: true });
       Puis dans app.module.ts, dans l'importation, ya routing. 
       Ca veut dire qu'on importe le module routeur dans notre module racine. 
       Dans l'AppModule, forRoot() va fournir les composants ET les services du router.

     
      
      + egalement,

*/

import { NgModule } from "@angular/core";
import { GN2CommonModule } from "@geonature_common/GN2Common.module";
import { CommonModule } from "@angular/common";
import { Routes, RouterModule } from "@angular/router";
import { ViewTestComponent } from "./view-test/view-test.component";
import { HttpClient } from "@angular/common/http";
import { DataService } from "./services/data.service";
import { HttpClientModule, HttpClientXsrfModule } from "@angular/common/http";
import { StoreService } from "./services/store.service";
import { DetailVisitComponent } from "./detail-visit/detail-visit.component";
import { ZpMapListComponent } from "./zp-map-list/zp-map-list.component";
import { ListVisitComponent } from "./list-visit/list-visit.component";
import { FormService } from "./services/form.service";
import { FormVisitComponent } from "./form-visit/form-visit.component";

// my module routing
const routes: Routes = 
[{ path: "", component: ZpMapListComponent},
 { path: "listVisit/:idSite", component: ListVisitComponent},
 {path: "editVisit/:idSite", component: FormVisitComponent},
 {path: "infoVisit/:idVisit", component: DetailVisitComponent },
 {path: "editVisit/:idSite/visit/:idVisit", component: FormVisitComponent,}

  
 ];

@NgModule({
/*
Un module angular se matérialise par une classe portant le décorateur @NgModule. 
@NgModule est une fonction qui modifie une class JS pour y ajouter des méta-données. 
Elle prend en paramètre un unique objet possédant diverses propriétées.
*/
  declarations: [ZpMapListComponent, ListVisitComponent, DetailVisitComponent, FormVisitComponent,],
// declarations: On déclare ici toutes les classes de vue (si je comprends bien, toutes les components ayant le fichier html )
  imports: [
  // imports: déclarer les modules dont dépend notre module 

    GN2CommonModule,
    HttpClientXsrfModule.withOptions({
      cookieName: 'token',
      headerName: 'token'
    }),
    // Xsrf : type de vulnérabilité des services d'authentification web. 
    // L'idée est de  transmettre à un utilisateur authentifié une requête HTTP falsifiée 
    // qui pointe sur une action interne au site, afin qu'il l'exécute sans en avoir conscience et en utilisant ses propres droits
    // Cette propriété HttpClientXsrfModule ajoute le support de protection XSRF aux requêtes sortantes. 
    // Pour un serveur qui prend en charge un système de protection XSRF basé sur les cookies, 
    // on utilise cette méthode directement pour configurer la protection XSRF avec les noms de cookie et d'en-tête appropriés.
    
    RouterModule.forChild(routes),
    // pour le RouterModule, il faut utiliser RouterModule.forChild, ce module est un module fils,
    // et non le module racine de l'application. Le forChild fournit SEULEMENT les composants (sans refournir à nouveaux les services)
    // Comme le routeur conserve un état (l'ensemble des routes), il ne s'agit pas d'en avoir 2 instances dans l'application.  
    CommonModule
    // + vu que SFT est une module fils de l'application GeoNature - qui est le module racine - ce module fils SFT n'importe pas 
    // BrowserModule (dans app.module.ts de GeoNature, ya bien BrowserModule). A la place, il importe CommonModule. 
  ],
  providers: [HttpClient, DataService, StoreService, FormService],
  // providers: déclarer les services qu'on va créer. 
  bootstrap: [],
  // Cette propriété définit le root component qui contiendra l'ensemble des autres components. 
  // En gros, on doit indiquer à Angular quel composant est le composant racine, c'ad le composant qu'on doit instancier
  // quand l'application démarre. 
  // Seul le root module peut déclarer cette propriété (c'ad ya que dans le fichier app.module.ts que cette propriété soit déclarée)
  
})

export class GeonatureModule {

}
