SET statement_timeout = 0;
SET lock_timeout = 0;
SET client_encoding = 'UTF8';
SET standard_conforming_strings = on;
SET check_function_bodies = false;
SET client_min_messages = warning;

SET search_path = pr_monitoring_flora_territory, pg_catalog;


-- to create the nomenclature of perturbations-- 
INSERT INTO ref_nomenclatures.bib_nomenclatures_types (mnemonique, label_default, definition_default, label_fr, definition_fr)
    VALUES ('TYPE_PERTURBATION', 'Type de perturbations', 'Nomenclature des types de perturbations.', 'Type de perturbations', 'Nomenclatures des types de perturbations.');


INSERT INTO ref_nomenclatures.t_nomenclatures (id_type, cd_nomenclature, mnemonique, label_default, definition_default, label_fr, definition_fr, id_broader, hierarchy) VALUES 
(ref_nomenclatures.get_id_nomenclature_type('TYPE_PERTURBATION'), 'GeF', 'Gestion par le feu', 'Gestion par le feu', 'Type de perturbation: Gestion par le feu', 'Gestion par le feu', 'Type de perturbation: Gestion par le feu', 0, '118.001'),
(ref_nomenclatures.get_id_nomenclature_type('TYPE_PERTURBATION'), 'Bru', 'Brûlage contrôlé', 'Brûlage contrôlé', 'Gestion par le feu: Brûlage contrôlé', 'Brûlage contrôlé', 'Gestion par le feu: Brûlage contrôlé', ref_nomenclatures.get_id_nomenclature('TYPE_PERTURBATION', 'Bru') , '118.503.001'),
(ref_nomenclatures.get_id_nomenclature_type('TYPE_PERTURBATION'), 'Inc', 'Incendie', 'Incendie (naturel ou incontrôlé)', 'Gestion par le feu: Incendie (naturel ou incontrôlé)', 'Incendie (naturel ou incontrôlé)', 'Gestion par le feu: Incendie (naturel ou incontrôlé)', ref_nomenclatures.get_id_nomenclature('TYPE_PERTURBATION', 'Inc'), '118.503.002'),
(ref_nomenclatures.get_id_nomenclature_type('TYPE_PERTURBATION'), 'AcL', 'Activité de loisirs', 'Activité de loisirs', 'Type de perturbation: Activité de loisirs', 'Activité de loisirs', 'Type de perturbation: Activité de loisirs', 0, '118.002'),
(ref_nomenclatures.get_id_nomenclature_type('TYPE_PERTURBATION'), 'Rec', 'Récolte des fleurs', 'Récolte des fleurs', 'Activité de loisirs: Récolte des fleurs', 'Récolte des fleurs', 'Activité de loisirs: Récolte des fleurs', ref_nomenclatures.get_id_nomenclature('TYPE_PERTURBATION', 'Rec') , '118.506.001'),
(ref_nomenclatures.get_id_nomenclature_type('TYPE_PERTURBATION'), 'Arr', 'Arrachage des pieds', 'Arrachage des pieds', 'Activité de loisirs: Arrachage des pieds', 'Arrachage des pieds', 'Activité de loisirs: Arrachage des pieds', ref_nomenclatures.get_id_nomenclature('TYPE_PERTURBATION', 'Arr'), '118.506.002'),
(ref_nomenclatures.get_id_nomenclature_type('TYPE_PERTURBATION'), 'Pie', 'Piétinement pédestre', 'Piétinement pédestre', 'Activité de loisirs: Piétinement pédestre', 'Piétinement pédestre', 'Activité de loisirs: Piétinement pédestre', ref_nomenclatures.get_id_nomenclature('TYPE_PERTURBATION', 'Pie'), '118.506.003'),
(ref_nomenclatures.get_id_nomenclature_type('TYPE_PERTURBATION'), 'Veh', 'Véhicules à moteur', 'Véhicules à moteur', 'Activité de loisirs: Véhicules à moteur', 'Véhicules à moteur', 'Activité de loisirs: Véhicules à moteur', ref_nomenclatures.get_id_nomenclature('TYPE_PERTURBATION', 'Veh'), '118.506.004'),
(ref_nomenclatures.get_id_nomenclature_type('TYPE_PERTURBATION'), 'Plo', 'Plongée dans un lac', 'Plongée dans un lac', 'Activité de loisirs: Plongée dans un lac', 'Plongée dans un lac', 'Activité de loisirs: Plongée dans un lac', ref_nomenclatures.get_id_nomenclature('TYPE_PERTURBATION', 'Plo'), '118.506.005'),
(ref_nomenclatures.get_id_nomenclature_type('TYPE_PERTURBATION'), 'GeE', 'Gestion de l''eau', 'Gestion de l''eau', 'Type de perturbation: Gestion de l''eau', 'Gestion de l''eau', 'Type de perturbation: Gestion de l''eau', 0, '118.003'),
(ref_nomenclatures.get_id_nomenclature_type('TYPE_PERTURBATION'), 'Pom', 'Pompage', 'Pompage', 'Gestion de l''eau: Pompage', 'Pompage', 'Gestion de l''eau: Pompage', ref_nomenclatures.get_id_nomenclature('TYPE_PERTURBATION', 'Pom'), '118.003'),
(ref_nomenclatures.get_id_nomenclature_type('TYPE_PERTURBATION'), 'Drn', 'Drainage', 'Drainage', 'Gestion de l''eau: Drainage', 'Drainage', 'Gestion de l''eau: Drainage', ref_nomenclatures.get_id_nomenclature('TYPE_PERTURBATION', 'Drn'), '118.529.001'),
(ref_nomenclatures.get_id_nomenclature_type('TYPE_PERTURBATION'), 'Irg', 'Irrigation par gravité', 'Irrigation par gravité', 'Gestion de l''eau: Irrigation par gravité', 'Irrigation par gravité', 'Gestion de l''eau: Irrigation par gravité', ref_nomenclatures.get_id_nomenclature('TYPE_PERTURBATION', 'Irg'), '118.529.002'),
(ref_nomenclatures.get_id_nomenclature_type('TYPE_PERTURBATION'), 'Ira', 'Irrigation par aspersion', 'Irrigation par aspersion', 'Gestion de l''eau: Irrigation par aspersion', 'Irrigation par aspersion', 'Gestion de l''eau: Irrigation par aspersion', ref_nomenclatures.get_id_nomenclature('TYPE_PERTURBATION', 'Ira'), '118.529.003'),
(ref_nomenclatures.get_id_nomenclature_type('TYPE_PERTURBATION'), 'Cur', 'Curage', 'Curage', 'Gestion de l''eau: Curage (fossé, mare, serve)', 'Curage', 'Gestion de l''eau: Curage (fossé, mare, serve)', ref_nomenclatures.get_id_nomenclature('TYPE_PERTURBATION', 'Cur'), '118.529.004'),
(ref_nomenclatures.get_id_nomenclature_type('TYPE_PERTURBATION'), 'Ext', 'Extraction de granulats', 'Extraction de granulats', 'Gestion de l''eau: Extraction de granulats', 'Extraction de granulats', 'Gestion de l''eau: Extraction de granulats', ref_nomenclatures.get_id_nomenclature('TYPE_PERTURBATION', 'Ext'), '118.529.005'),
(ref_nomenclatures.get_id_nomenclature_type('TYPE_PERTURBATION'), 'AcA', 'Activités agricoles', 'Activités agricoles', 'Type de perturbation: Activités agricoles', 'Activités agricoles', 'Type de perturbation: Activités agricoles', 0, '118.004'),
(ref_nomenclatures.get_id_nomenclature_type('TYPE_PERTURBATION'), 'Lab', 'Labour', 'Labour', 'Activités agricoles: Labour', 'Labour', 'Activités agricoles: Labour', ref_nomenclatures.get_id_nomenclature('TYPE_PERTURBATION', 'Lab'), '118.536.001'),
(ref_nomenclatures.get_id_nomenclature_type('TYPE_PERTURBATION'), 'Fer', 'Fertilisation', 'Fertilisation', 'Activités agricoles: Fertilisation', 'Fertilisation', 'Activités agricoles: Fertilisation', ref_nomenclatures.get_id_nomenclature('TYPE_PERTURBATION', 'Fer'), '118.536.002'),
(ref_nomenclatures.get_id_nomenclature_type('TYPE_PERTURBATION'), 'Prp', 'Produits phyosanitaires', 'Produits phyosanitaires', 'Activités agricoles: Produits phyosanitaires (épandage)', 'Produits phyosanitaires', 'Activités agricoles: Produits phyosanitaires (épandage)', ref_nomenclatures.get_id_nomenclature('TYPE_PERTURBATION', 'Prp'), '118.536.003'),
(ref_nomenclatures.get_id_nomenclature_type('TYPE_PERTURBATION'), 'Fauc', 'Fauchaison', 'Fauchaison', 'Activités agricoles: Fauchaison', 'Fauchaison', 'Activités agricoles: Fauchaison', ref_nomenclatures.get_id_nomenclature('TYPE_PERTURBATION', 'Fauc'), '118.536.004'),
(ref_nomenclatures.get_id_nomenclature_type('TYPE_PERTURBATION'), 'Apb', 'Apport de blocs', 'Apport de blocs', 'Activités agricoles: Apport de blocs (déterrés par le labour)', 'Apport de blocs', 'Activités agricoles: Apport de blocs (déterrés par le labour)', ref_nomenclatures.get_id_nomenclature('TYPE_PERTURBATION', 'Apb'), '118.536.005'),
(ref_nomenclatures.get_id_nomenclature_type('TYPE_PERTURBATION'), 'Gyr', 'Gyrobroyage', 'Gyrobroyage', 'Activités agricoles: Gyrobroyage', 'Gyrobroyage', 'Activités agricoles: Gyrobroyage', ref_nomenclatures.get_id_nomenclature('TYPE_PERTURBATION', 'Gyr'), '118.536.006'),
(ref_nomenclatures.get_id_nomenclature_type('TYPE_PERTURBATION'), 'Reg', 'Revégétalisation', 'Revégétalisation', 'Activités agricoles: Revégétalisation (sur semis)', 'Revégétalisation', 'Activités agricoles: Revégétalisation (sur semis)', ref_nomenclatures.get_id_nomenclature('TYPE_PERTURBATION', 'Reg'), '118.536.007'),
(ref_nomenclatures.get_id_nomenclature_type('TYPE_PERTURBATION'), 'AcF', 'Activités forestières', 'Activités forestières', 'Type de perturbation: Activités forestières', 'Activités forestières', 'Type de perturbation: Activités forestières', 0, '118.005'),
(ref_nomenclatures.get_id_nomenclature_type('TYPE_PERTURBATION'), 'Jpf', 'Jeune plantation de feuillus', 'Jeune plantation de feuillus', 'Activités forestières: Jeune plantation de feuillus', 'Jeune plantation de feuillus', 'Activités forestières: Jeune plantation de feuillus', ref_nomenclatures.get_id_nomenclature('TYPE_PERTURBATION', 'Jpf'), '118.544.001'),
(ref_nomenclatures.get_id_nomenclature_type('TYPE_PERTURBATION'), 'Jpm', 'Jeune plantation mixte', 'Jeune plantation mixte', 'Activités forestières: Jeune plantation mixte', 'Jeune plantation mixte', 'Activités forestières: Jeune plantation mixte', ref_nomenclatures.get_id_nomenclature('TYPE_PERTURBATION', 'Jpm'), '118.544.002'),
(ref_nomenclatures.get_id_nomenclature_type('TYPE_PERTURBATION'), 'Jpr', 'Jeune plantation de résineux', 'Jeune plantation de résineux', 'Activités forestières: Jeune plantation de résineux', 'Jeune plantation de résineux', 'Activités forestières: Jeune plantation de résineux', ref_nomenclatures.get_id_nomenclature('TYPE_PERTURBATION', 'Jpr'), '118.544.003'),
(ref_nomenclatures.get_id_nomenclature_type('TYPE_PERTURBATION'), 'Ela', 'Elagage', 'Elagage', 'Activités forestières: Elagage (haie et bord de route)', 'Elagage', 'Activités forestières: Elagage (haie et bord de route)', ref_nomenclatures.get_id_nomenclature('TYPE_PERTURBATION', 'Ela'), '118.544.004'),
(ref_nomenclatures.get_id_nomenclature_type('TYPE_PERTURBATION'), 'Cec', 'Coupe d''éclaircie', 'Coupe d''éclaircie', 'Activités forestières: Coupe d''éclaircie', 'Coupe d''éclaircie', 'Activités forestières: Coupe d''éclaircie', ref_nomenclatures.get_id_nomenclature('TYPE_PERTURBATION', 'Cec'), '118.544.005'),
(ref_nomenclatures.get_id_nomenclature_type('TYPE_PERTURBATION'), 'Cbl', 'Coupe à blanc', 'Coupe à blanc', 'Activités forestières: Coupe à blanc', 'Coupe à blanc', 'Activités forestières: Coupe à blanc', ref_nomenclatures.get_id_nomenclature('TYPE_PERTURBATION', 'Cbl'), '118.544.006'),
(ref_nomenclatures.get_id_nomenclature_type('TYPE_PERTURBATION'), 'Bcl', 'Bois coupé et laissé', 'Bois coupé et laissé', 'Activités forestières: Bois coupé et laissé sur place', 'Bois coupé et laissé', 'Activités forestières: Bois coupé et laissé sur place', ref_nomenclatures.get_id_nomenclature('TYPE_PERTURBATION', 'Bcl'), '118.544.007'),
(ref_nomenclatures.get_id_nomenclature_type('TYPE_PERTURBATION'), 'Opf', 'Ouverture de piste forestière', 'Ouverture de piste forestière', 'Activités forestières: Ouverture de piste forestière', 'Ouverture de piste forestière', 'Activités forestières: Ouverture de piste forestière', ref_nomenclatures.get_id_nomenclature('TYPE_PERTURBATION', 'Opf'), '118.544.008'),
(ref_nomenclatures.get_id_nomenclature_type('TYPE_PERTURBATION'), 'CpA', 'Comportement des animaux', 'Comportement des animaux', 'Type de perturbation: Comportement des animaux', 'Comportement des animaux', 'Type de perturbation: Comportement des animaux', 0, '118.006'),
(ref_nomenclatures.get_id_nomenclature_type('TYPE_PERTURBATION'), 'Jas', 'Jas', 'Jas', 'Comportement des animaux: Jas (couchades nocturnes des animaux domestiques)', 'Jas', 'Comportement des animaux: Jas (couchades nocturnes des animaux domestiques)', ref_nomenclatures.get_id_nomenclature('TYPE_PERTURBATION', 'Jas'), '118.553.001'),
(ref_nomenclatures.get_id_nomenclature_type('TYPE_PERTURBATION'), 'Cha', 'Chaume', 'Chaume', 'Comportement des animaux: Chaume (couchades aux heures chaudes des animaux domestiques)', 'Chaume', 'Comportement des animaux: Chaume (couchades aux heures chaudes des animaux domestiques)', ref_nomenclatures.get_id_nomenclature('TYPE_PERTURBATION', 'Cha'), '118.553.002'),
(ref_nomenclatures.get_id_nomenclature_type('TYPE_PERTURBATION'), 'Faus', 'Faune sauvage', 'Faune sauvage', 'Comportement des animaux: Faune sauvage (reposoir)', 'Faune sauvage', 'Comportement des animaux: Faune sauvage (reposoir)', ref_nomenclatures.get_id_nomenclature('TYPE_PERTURBATION', 'Faus'), '118.553.003'),
(ref_nomenclatures.get_id_nomenclature_type('TYPE_PERTURBATION'), 'Psa', 'Piétinement sans déjection', 'Piétinement sans déjection', 'Comportement des animaux: Piétinement, sans apports de déjection', 'Piétinement sans déjection', 'Comportement des animaux: Piétinement, sans apports de déjection', ref_nomenclatures.get_id_nomenclature('TYPE_PERTURBATION', 'Psa'), '118.553.004'),
(ref_nomenclatures.get_id_nomenclature_type('TYPE_PERTURBATION'), 'Pat', 'Pâturage', 'Pâturage', 'Comportement des animaux: Pâturage (sur herbacées exclusivement)', 'Pâturage', 'Comportement des animaux: Pâturage (sur herbacées exclusivement)', ref_nomenclatures.get_id_nomenclature('TYPE_PERTURBATION', 'Pat'), '118.553.005'),
(ref_nomenclatures.get_id_nomenclature_type('TYPE_PERTURBATION'), 'Acl', 'Abroutissement et écorçage ', 'Abroutissement et écorçage ', 'Comportement des animaux: Abroutissement et écorçage (sur ligneux)', 'Abroutissement et écorçage ', 'Comportement des animaux: Abroutissement et écorçage (sur ligneux)', ref_nomenclatures.get_id_nomenclature('TYPE_PERTURBATION', 'Acl'), '118.553.006'),
(ref_nomenclatures.get_id_nomenclature_type('TYPE_PERTURBATION'), 'San', 'Sangliers labours grattis', 'Sangliers labours grattis', 'Comportement des animaux: Sangliers-labours et grattis', 'Sangliers labours grattis', 'Comportement des animaux: Sangliers-labours et grattis', ref_nomenclatures.get_id_nomenclature('TYPE_PERTURBATION', 'San'), '118.553.007'),
(ref_nomenclatures.get_id_nomenclature_type('TYPE_PERTURBATION'), 'Mar', 'Marmottes terriers', 'Marmottes terriers', 'Comportement des animaux: Marmottes-terriers', 'Marmottes terriers', 'Comportement des animaux: Marmottes-terriers', ref_nomenclatures.get_id_nomenclature('TYPE_PERTURBATION', 'Mar'), '118.553.008'),
(ref_nomenclatures.get_id_nomenclature_type('TYPE_PERTURBATION'), 'Che', 'Chenilles défoliation', 'Chenilles défoliation', 'Comportement des animaux: Chenilles-défoliation', 'Chenilles défoliation', 'Comportement des animaux: Chenilles-défoliation', ref_nomenclatures.get_id_nomenclature('TYPE_PERTURBATION', 'Che'), '118.553.009'),
(ref_nomenclatures.get_id_nomenclature_type('TYPE_PERTURBATION'), 'PnE', 'Processus naturels d''érosion', 'Processus naturels d''érosion', 'Type de perturbation: Processus naturels d''érosion', 'Processus naturels d''érosion', 'Type de perturbation: Processus naturels d''érosion', 0, '118.007'),
(ref_nomenclatures.get_id_nomenclature_type('TYPE_PERTURBATION'), 'Sub', 'Submersion temporaire', 'Submersion temporaire', 'Processus naturels d''érosion: Submersion temporaire', 'Submersion temporaire', 'Processus naturels d''érosion: Submersion temporaire', ref_nomenclatures.get_id_nomenclature('TYPE_PERTURBATION', 'Sub'), '118.563.001'),
(ref_nomenclatures.get_id_nomenclature_type('TYPE_PERTURBATION'), 'Env', 'Envasement', 'Envasement', 'Processus naturels d''érosion: Envasement', 'Envasement', 'Processus naturels d''érosion: Envasement', ref_nomenclatures.get_id_nomenclature('TYPE_PERTURBATION', 'Env'), '118.563.002'),
(ref_nomenclatures.get_id_nomenclature_type('TYPE_PERTURBATION'), 'Eng', 'Engravement', 'Engravement', 'Processus naturels d''érosion: Engravement (laves torrentielles et divagation d''une rivière)', 'Engravement', 'Processus naturels d''érosion: Engravement (laves torrentielles et divagation d''une rivière)', ref_nomenclatures.get_id_nomenclature('TYPE_PERTURBATION', 'Eng'), '118.563.003'),
(ref_nomenclatures.get_id_nomenclature_type('TYPE_PERTURBATION'), 'Aam', 'Avalanche apport matériaux', 'Avalanche apport matériaux', 'Processus naturels d''érosion: Avalanche (apport de matériaux non triés)', 'Avalanche', 'Processus naturels d''érosion: Avalanche (apport de matériaux non triés)', ref_nomenclatures.get_id_nomenclature('TYPE_PERTURBATION', 'Aam'), '118.563.004'),
(ref_nomenclatures.get_id_nomenclature_type('TYPE_PERTURBATION'), 'Evs', 'Erosion vastes surfaces', 'Erosion vastes surfaces', 'Processus naturels d''érosion:Erosion s''exerçant sur de vastes surfaces', 'Erosion vastes surfaces', 'Processus naturels d''érosion:Erosion s''exerçant sur de vastes surfaces', ref_nomenclatures.get_id_nomenclature('TYPE_PERTURBATION', 'Evs'), '118.563.005'),
(ref_nomenclatures.get_id_nomenclature_type('TYPE_PERTURBATION'), 'Sbe', 'Sapement berge', 'Sapement berge', 'Processus naturels d''érosion: Sapement de la berge d''un cours d''eau', 'Sapement berge', 'Processus naturels d''érosion: Sapement de la berge d''un cours d''eau', ref_nomenclatures.get_id_nomenclature('TYPE_PERTURBATION', 'Sbe'), '118.563.006'),
(ref_nomenclatures.get_id_nomenclature_type('TYPE_PERTURBATION'), 'Art', 'Avalanche ramonage terrain', 'Avalanche ramonage terrain', 'Processus naturels d''érosion: Avalanche-ramonage du terrain', 'Avalanche ramonage terrain', 'Processus naturels d''érosion: Avalanche-ramonage du terrain', ref_nomenclatures.get_id_nomenclature('TYPE_PERTURBATION', 'Art'), '118.563.007'),
(ref_nomenclatures.get_id_nomenclature_type('TYPE_PERTURBATION'), 'Ebr', 'Eboulement récent', 'Eboulement récent', 'Processus naturels d''érosion: Eboulement récent', 'Eboulement récent', 'Processus naturels d''érosion: Eboulement récent', ref_nomenclatures.get_id_nomenclature('TYPE_PERTURBATION', 'Ebr'), '118.563.008'),
(ref_nomenclatures.get_id_nomenclature_type('TYPE_PERTURBATION'), 'AmL', 'Aménagements lourds', 'Aménagements lourds', 'Type de perturbation: Aménagements lourds', 'Aménagements lourds', 'Type de perturbation: Aménagements lourds', 0, '118.008'),
(ref_nomenclatures.get_id_nomenclature_type('TYPE_PERTURBATION'), 'Car', 'Carrière en roche dure', 'Carrière en roche dure', 'Aménagements lourds: Carrière en roche dure', 'Carrière en roche dure', 'Aménagements lourds: Carrière en roche dure', ref_nomenclatures.get_id_nomenclature('TYPE_PERTURBATION', 'Car'), '118.572.001'),
(ref_nomenclatures.get_id_nomenclature_type('TYPE_PERTURBATION'), 'Fos', 'Fossé pare-blocs', 'Fossé pare-blocs', 'Aménagements lourds: Fossé pare-blocs', 'Fossé pare-blocs', 'Aménagements lourds: Fossé pare-blocs', ref_nomenclatures.get_id_nomenclature('TYPE_PERTURBATION', 'Fos'), '118.572.002'),
(ref_nomenclatures.get_id_nomenclature_type('TYPE_PERTURBATION'), 'End', 'Endiguement', 'Endiguement', 'Aménagements lourds: Endiguement', 'Endiguement', 'Aménagements lourds: Endiguement', ref_nomenclatures.get_id_nomenclature('TYPE_PERTURBATION', 'End'), '118.572.003'),
(ref_nomenclatures.get_id_nomenclature_type('TYPE_PERTURBATION'), 'Ter', 'Terrassement aménagements lourds', 'Terrassement aménagements lourds', 'Aménagements lourds: Terrassement pour aménagements lourds', 'Terrassement aménagements lourds', 'Aménagements lourds: Terrassement pour aménagements lourds', ref_nomenclatures.get_id_nomenclature('TYPE_PERTURBATION', 'Ter'), '118.572.004'),
(ref_nomenclatures.get_id_nomenclature_type('TYPE_PERTURBATION'), 'Deb', 'Déboisement avec désouchage', 'Déboisement avec désouchage', 'Aménagements lourds: Déboisement avec désouchage', 'Déboisement avec désouchage', 'Aménagements lourds: Déboisement avec désouchage', ref_nomenclatures.get_id_nomenclature('TYPE_PERTURBATION', 'Deb'), '118.572.005'),
(ref_nomenclatures.get_id_nomenclature_type('TYPE_PERTURBATION'), 'Beg', 'Béton-goudron:revêtement', 'Béton-goudron:revêtement', 'Aménagements lourds: Béton, goudron-revêtement abiotique', 'Béton-goudron:revêtement', 'Aménagements lourds: Béton, goudron-revêtement abiotique', ref_nomenclatures.get_id_nomenclature('TYPE_PERTURBATION', 'Beg'), '118.572.006'),
(ref_nomenclatures.get_id_nomenclature_type('TYPE_PERTURBATION'), 'GeI', 'Gestion des invasives', 'Gestion des invasives', 'Type de perturbation: Gestion des invasives', 'Gestion des invasives', 'Type de perturbation: Gestion des invasives', 0, '118.009'),
(ref_nomenclatures.get_id_nomenclature_type('TYPE_PERTURBATION'), 'Arg', 'Arrachage', 'Arrachage', 'Gestion des invasives: Arrachage', 'Arrachage', 'Gestion des invasives: Arrachage', ref_nomenclatures.get_id_nomenclature('TYPE_PERTURBATION', 'Arg'), '118.879.001'),
(ref_nomenclatures.get_id_nomenclature_type('TYPE_PERTURBATION'), 'Fag', 'Fauchage', 'Fauchage', 'Gestion des invasives: Fauchage', 'Fauchage', 'Gestion des invasives: Fauchage', ref_nomenclatures.get_id_nomenclature('TYPE_PERTURBATION', 'Fag'), '118.879.002'),
(ref_nomenclatures.get_id_nomenclature_type('TYPE_PERTURBATION'), 'Dbs', 'Débroussaillage', 'Débroussaillage', 'Gestion des invasives: Débroussaillage', 'Débroussaillage', 'Gestion des invasives: Débroussaillage', ref_nomenclatures.get_id_nomenclature('TYPE_PERTURBATION', 'Dbs'), '118.879.003'),
(ref_nomenclatures.get_id_nomenclature_type('TYPE_PERTURBATION'), 'Reb', 'Recouvrement avec bâches', 'Recouvrement avec bâches', 'Gestion des invasives: Recouvrement avec bâches', 'Recouvrement avec bâches', 'Gestion des invasives:Recouvrement avec bâches', ref_nomenclatures.get_id_nomenclature('TYPE_PERTURBATION', 'Reb'), '118.879.004')






INSERT INTO ref_nomenclatures.t_nomenclatures (id_type, cd_nomenclature, mnemonique, label_default, label_fr, definition_fr )
VALUES (ref_nomenclatures.get_id_nomenclature_type('TYPE_SITE'), 'ZP', 'Zone de prospection', 'Zone de prospection - suivi flore territoire', 'Zone de prospection',  'Zone de prospection issu du module suivi flore territoire');

-- PROVISOIRE A ADAPTER GRACE AU SHAPEFILE DU CBNA
INSERT INTO gn_monitoring.t_base_sites
(id_inventor, id_digitiser, id_nomenclature_type_site, base_site_name, base_site_description, base_site_code, first_use_date, geom )
SELECT 1, 1, ref_nomenclatures.get_id_nomenclature('TYPE_SITE', 'ZP'), 'zp', '', id, '01-01-2018', ST_TRANSFORM(ST_SetSRID(geom, 2154), 4326)
FROM pr_monitoring_flora_territory.zp_tmp;

INSERT INTO pr_monitoring_flora_territory.t_infos_site (id_base_site, cd_nom)
SELECT id_base_site, zp.cd_nom
FROM gn_monitoring.t_base_sites bs
JOIN pr_monitoring_flora_territory.zp_tmp zp ON zp.id::character varying = bs.base_site_code;

--TODO--
-- parametrer ref_geo.bib_areas_types -- 
INSERT INTO ref_geo.bib_areas_types (id_type, type_name, type_desc)
VALUES (203, 'Mailles25*25', 'Maille INPN 50*50 redécoupé en 25m');

INSERT INTO ref_geo.l_areas (id_type, area_name, area_code, geom, centroid, source)
SELECT 203, id, id, geom, ST_CENTROID(geom), 'INPN'
FROM pr_monitoring_flora_territory.maille_tmp;

INSERT INTO ref_geo.li_grids
SELECT area_code, id_area, ST_XMin(ST_Extent(geom)), ST_XMax(ST_Extent(geom)), ST_YMin(ST_Extent(geom)),ST_YMax(ST_Extent(geom))
FROM ref_geo.l_areas
WHERE id_type=203
GROUP by area_code, id_area;


INSERT INTO gn_monitoring.cor_site_area (id_base_site, id_area)
SELECT bs.id_base_site, a.id_area 
FROM ref_geo.l_areas a
JOIN gn_monitoring.t_base_sites bs ON ST_Within(ST_TRANSFORM(a.geom, 4326), bs.geom)
WHERE id_type=203;

-- TODO Mettre en paramètre l'id du module
INSERT INTO gn_monitoring.cor_site_application
SELECT  bs.id_base_site, MY_ID_MODULE
FROM gn_monitoring.t_base_sites bs
JOIN pr_monitoring_flora_territory.zp_tmp zp ON bs.base_site_code  = zp.id::character varying;

DROP TABLE pr_monitoring_flora_territory.zp_tmp;
DROP TABLE pr_monitoring_flora_territory.maille_tmp;