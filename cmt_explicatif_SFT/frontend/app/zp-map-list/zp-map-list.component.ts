import { Component, OnInit, AfterViewInit, Input } from "@angular/core";
import { Router } from "@angular/router";

import { MapService } from "@geonature_common/map/map.service";
import { MapListService } from "@geonature_common/map-list/map-list.service";

import { DataService } from "../services/data.service";
import { StoreService } from "../services/store.service";
import { ModuleConfig } from "../module.config";

@Component({
  selector: "pnx-zp-map-list",
  templateUrl: "./zp-map-list.component.html",
  styleUrls: ["./zp-map-list.component.scss"]
})
export class ZpMapListComponent implements OnInit, AfterViewInit {
  public zps;

  @Input()
  searchTaxon: string;

  public filteredData = [];
  public tabOrganism = [];

  constructor(
    public mapService: MapService,
    private _api: DataService,
    public router: Router,
    public storeService: StoreService,
    public mapListService: MapListService
  ) {}

  ngOnInit() {
    this.mapListService.idName = "id_infos_site";
    //  pkoi c' id_infos_site et pas id_base_site?

    this._api
      .getZp({ id_application: ModuleConfig.id_application })
      .subscribe(data => {
        this.zps = data;

        data.features.forEach(elem => {
          this._api
            .getOrganisme({ id_base_site: elem.properties.id_base_site })
            .subscribe(organi => {
              this.tabOrganism = [];
              organi.forEach(result => {
                this.tabOrganism.push(result.nom_organisme);
              });
              elem.properties.nom_organisme = this.tabOrganism;
            });
        });

        this.mapListService.loadTableData(data);
        // on charge la tableData pour pouvoir afficher dans le ngx datatable

        this.filteredData = this.mapListService.tableData;
        // je stocke dans ma variable filteredData tout le contenu de mapListService.tableData
      });
  }

  ngAfterViewInit() {
    this.mapListService.enableMapListConnexion(this.mapService.getMap());
    // pour connecter le ngx datatable avec le map. Quand on clique sur map, ça souligne la ligne et vice versa
  }

  onEachFeature(feature, layer) {
    this.mapListService.layerDict[feature.id] = layer;

    /* layerDict est un objet.
      quand on met layerDict[feature.id] -> je veux la valeur de layerDict à la position [feature.id]
      En gros, feature.id est une clé de layerDict et on veut que layer soit sa valeur associé. C'ad:
      layerDict = {
        feature.id1: layer1,
        feature.id2 : layer2
      }
      */
    layer.on({
      click: e => {
        // toggle style
        this.mapListService.toggleStyle(layer);
        // pour colorer le layer
        this.mapListService.mapSelected.next(feature.id);
        // si on efface cette ligne, quand on clique sur la ZP, ça connecte plus avec le ngx datatable.
        // le mapSelected est un Subject -> on peut next sur celui là et en fonction de feature.id ?!?
        // (j'espère que c' comme ça qu'on peut expliquer  )
      }
    });
  }

  onInfo(id_base_site) {
    // quand on veut voir la liste de toutes les visites sur ce site
    this.router.navigate([`${ModuleConfig.api_url}/listVisit`, id_base_site]);
  }

  onSearchTaxon(event) {
    let trans = event.toLowerCase();
    // event ici correspond au string qu'on tape dans input.
    this.filteredData = this.mapListService.tableData.filter(
      // on retourne toujours filteredData (ce dont les données ne changent pas) et on filtre sur mapListService.tableData (ce sont les données changent)
      ligne => {
        return ligne.nom_taxon.toLowerCase().indexOf(trans) !== -1 || !trans;
      }
    );
  }

  onSearchDate(event) {
    let trans;
    if (event !== null) {
      trans = event.toString();
    }

    this.filteredData = this.mapListService.tableData.filter(ligne => {
      return ligne.date_max.indexOf(trans) !== -1 || !trans;
    });
  }

  onSearchOrganisme(event) {
    //  console.log("my event ", event);

    // let trans = event.toLowerCase();

    let select;

    this.filteredData = this.mapListService.tableData.filter(ligne => {
      ligne.nom_organisme.forEach(el => {
        if (el.trim() === event) {
          select = el.trim();
          // on enlève les espaces pour qu'il ne reste que le string du nom de l'organisme (qui se trouve dans tabOrganism).
          // on va voir si ça correspond à l'option chosie
          //  si oui, on stocke dans la variable select le nom de l'organisme
        }
      });

      /* for (let i = 0; i < ligne.nom_organisme.length; i++) {
               if (ligne.nom_organisme[i].trim() === event) {
                  select = ligne.nom_organisme[i].trim()
               } 
            } */
      // on peut écrire si aussi
      return select;
      //  et on retourne select, quoi que ce soit.
    });
  }
}
