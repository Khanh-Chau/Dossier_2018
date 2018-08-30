import { Injectable } from '@angular/core';
import { Layer } from 'leaflet';
import { NgbDateParserFormatter, NgbModal } from '@ng-bootstrap/ng-bootstrap';

@Injectable()
export class StoreService {

public currentLayer: Layer;


public myStylePresent = {
    color: "#008000",
    fill: true,
    fillOpacity: 0.2,
    weight: 3
};

public myStyleAbsent = {
    color: "#8B0000",
    fill: true,
    fillOpacity: 0.2,
    weight: 3
};

public presence = 0;
public absence = 0; 
public total = 0;
public rest = 0; 
public exportFormat = ['geojson', 'csv', 'shapefile'];

    
    constructor(private _modalService: NgbModal) { } 
   

    getMailleNoVisit() {
        // calculer les mailles ne sont pas encore visitées
        this.rest = this.total - this.absence - this.presence;
     }
   
    openIntesectionModal(content) {
        // ouvrir un modal quand clique 
        this._modalService.open(content);
      }

/* 
ces 2 méthodes je les mets ici pour que plusieurs composants puissent les utiliser. 
*/
}