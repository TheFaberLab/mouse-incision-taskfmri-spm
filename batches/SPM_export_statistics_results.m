% to save the results of statistics 
Num = spm_get_defaults('stats.results.svc.nbmax');
Dis = spm_get_defaults('stats.results.svc.distmin');
TabDat = spm_list('List',xSPM,hReg,[Num,Dis]);
save([xSPM.swd '\' 'statistics'],'TabDat');

statistics1 = cell2table(TabDat.dat(:,1:2));
statistics2 = TabDat.dat(:,3:11);
TF = cellfun(@(x) all(isinf(x)), statistics2);
[row,col] = find(TF==1 & TF==1);
for i = 1:length(row)
    statistics2{row(i),col(i)} = [];
end
Coordinates = cell2mat(TabDat.dat(:,12))';
Coordinates = reshape(Coordinates,3,length(Coordinates)/3)';

statistics = [statistics1,cell2table(statistics2)];
statistics = [statistics,array2table(Coordinates)];

% to add the title of each column but it didn't work!!
% statistics = table2cell(statistics);
% load('M:\04. Data\fMRI\SPM_results_statistics_pvalue_tilte.mat');
% Properties = cell2table(SPMresultsstatisticspvaluetilte);
% C = statistics.Properties.VariableNames;
% Properties.Properties.VariableNames = C;
% Properties = table2struct(Properties);
% statistics = table2struct(statistics);
% excelfile = struct2table([Properties;statistics]);

statistics = table2cell(statistics);
% to remove inifinte
try
    xlswrite([xSPM.swd '\statistics.xls'],statistics);
catch % no Excel installed
    writecell(statistics,[xSPM.swd '\statistics.xlsx']);
end
% to call 
spm_list('display',TabDat,hReg);