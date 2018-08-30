import { Injectable, Inject } from "@angular/core";
import { FormControl, FormGroup, FormBuilder, Validators } from "@angular/forms";

@Injectable()
export class FormService {


   public disabled = true;    


   constructor(private _fb : FormBuilder) {
    // FormBuilder est une classe utilitaire, avec des méthodes facilitant la création d'objet FormGroup. 
   }

   
   initFormSFT(): FormGroup {
       /*  Plusieurs FormControl peuvent être regroupés dans un FormGroup pour constituer une partie du formulaire
      qui a des règles de validation communes. On l'appelle FormGroup un groupe de contrôle. 

   */
      const formSuivi = this._fb.group({
        // on utilise la méthode group pour créer une nouvelle instance de FormGroup. 
        //  la méthode group prendd comme un argument un objet où les clés correspondent aux noms de contrôles souhaitée, 
        //  et les valeurs correspondent aux valeurs par défaut de ces champs 
        // * nom de contrôle ici, je pense c' le champ de formulaire  * 
        id_base_site: null,
        id_base_visit: null,
        visit_date: [null, Validators.required],  
        cor_visit_observer: [null, Validators.required],
        cor_visit_perturbation: new Array(),
        cor_visit_grid: new Array(), 
        comments: null, 

      });
      return formSuivi;
   }
   

}