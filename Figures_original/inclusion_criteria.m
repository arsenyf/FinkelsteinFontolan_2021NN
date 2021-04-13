% clear all;

% Pyr all training
rel_good=EPHYS.Unit*EPHYS.UnitPosition*EPHYS.UnitCellType*EXP.SessionTraining & 'unit_quality="good" or unit_quality="ok"' &ANL.IncludeUnit2  & 'cell_type="Pyr"';
rel_good & 'brain_area="ALM"' & 'hemisphere="left"'
rel_good & 'brain_area="ALM"' & 'hemisphere="right"'
rel_good &  'brain_area="vS1"' & 'hemisphere="left"'

rel_multi=EPHYS.Unit*EPHYS.UnitPosition*EPHYS.UnitCellType*EXP.SessionTraining & 'unit_quality="multi" ' & ANL.IncludeUnit2  & 'cell_type="Pyr"';
rel_multi & 'brain_area="ALM"' & 'hemisphere="left"'
rel_multi & 'brain_area="ALM"' & 'hemisphere="right"'
rel_multi &  'brain_area="vS1"' & 'hemisphere="left"'


% Pyr
rel_good=EPHYS.Unit*EPHYS.UnitPosition*EPHYS.UnitCellType*EXP.SessionTraining & 'unit_quality="good" or unit_quality="ok"' &ANL.IncludeUnit2  & 'cell_type="Pyr"' & 'training_type="distractor"';
rel_good & 'brain_area="ALM"' & 'hemisphere="left"'
rel_good & 'brain_area="ALM"' & 'hemisphere="right"'
rel_good &  'brain_area="vS1"' & 'hemisphere="left"'

rel_multi=EPHYS.Unit*EPHYS.UnitPosition*EPHYS.UnitCellType*EXP.SessionTraining & 'unit_quality="multi" ' & ANL.IncludeUnit2  & 'cell_type="Pyr"' & 'training_type="distractor"';;
rel_multi & 'brain_area="ALM"' & 'hemisphere="left"'
rel_multi & 'brain_area="ALM"' & 'hemisphere="right"'
rel_multi &  'brain_area="vS1"' & 'hemisphere="left"'




% FS
rel_good=EPHYS.Unit*EPHYS.UnitPosition*EPHYS.UnitCellType*EXP.SessionTraining & 'unit_quality="good" or unit_quality="ok"' &ANL.IncludeUnit2  & 'cell_type="FS"';
rel_good & 'brain_area="ALM"' & 'hemisphere="left"'
rel_good & 'brain_area="ALM"' & 'hemisphere="right"'
rel_good &  'brain_area="vS1"' & 'hemisphere="left"'

rel_multi=EPHYS.Unit*EPHYS.UnitPosition*EPHYS.UnitCellType*EXP.SessionTraining & 'unit_quality="multi" ' & ANL.IncludeUnit2  & 'cell_type="FS"';
rel_multi & 'brain_area="ALM"' & 'hemisphere="left"'
rel_multi & 'brain_area="ALM"' & 'hemisphere="right"'
rel_multi &  'brain_area="vS1"' & 'hemisphere="left"'



% Pyr
rel_good=EPHYS.Unit*EPHYS.UnitPosition*EPHYS.UnitCellType*EXP.SessionTraining  &ANL.IncludeUnit2  & 'cell_type="Pyr"' & 'training_type="regular"';
rel_good & 'brain_area="ALM"' & 'hemisphere="left"'
rel_good & 'brain_area="ALM"' & 'hemisphere="right"'
rel_good &  'brain_area="vS1"' & 'hemisphere="left"'





% rel_good=EPHYS.Unit*EPHYS.UnitPosition*EPHYS.UnitCellType & 'unit_quality="good" or unit_quality="ok"'
% 
% rel_good&ANL.IncludeUnit
% 
% 
% rel_multi=EPHYS.Unit*EPHYS.UnitPosition*EPHYS.UnitCellType & 'unit_quality="multi"'
% 
% rel_multi&ANL.IncludeUnit
% 
% rel_all=EPHYS.Unit*EPHYS.UnitPosition*EPHYS.UnitCellType
% rel_all&ANL.IncludeUnit 
% 
% 
% 
% rel_multi&ANL.IncludeUnit
% 
% rel_all=EPHYS.Unit*EPHYS.UnitPosition*EPHYS.UnitCellType
% rel_all&ANL.IncludeUnit 
% 
% 
% 
% 
% 
% depth=fetchn(EPHYS.UnitPosition&ANL.IncludeUnit & 'brain_area="vS1"','unit_dv_location');
% [min(depth), max(depth)]
% 
% depth=fetchn(EPHYS.UnitPosition&ANL.IncludeUnit & 'brain_area="ALM"','unit_dv_location');
% [min(depth), max(depth)]