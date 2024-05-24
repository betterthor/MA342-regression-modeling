clear all
close all

ballData = readtable("teamsUpdated.csv");

seriesWinners = ballData.WorldSeriesWinner;
ballData = removevars(ballData,["Year","League"]);


ana_rows = matches(ballData.Franchise,'ANA'); ana_data=ballData(ana_rows,:); %head(ana_data.Franchise,3)
ari_rows = matches(ballData.Franchise,'ARI'); ari_data=ballData(ari_rows,:);
atl_rows = matches(ballData.Franchise,'ATL'); atl_data=ballData(atl_rows,:);
bal_rows = matches(ballData.Franchise,'BAL'); bal_data=ballData(bal_rows,:);
bos_rows = matches(ballData.Franchise,'BOS'); bos_data=ballData(bos_rows,:);
chc_rows = matches(ballData.Franchise,'CHC'); chc_data=ballData(chc_rows,:);
chw_rows = matches(ballData.Franchise,'CHW'); chw_data=ballData(chw_rows,:);
cin_rows = matches(ballData.Franchise,'CIN'); cin_data=ballData(cin_rows,:);
cle_rows = matches(ballData.Franchise,'CLE'); cle_data=ballData(cle_rows,:);
col_rows = matches(ballData.Franchise,'COL'); col_data=ballData(col_rows,:);
det_rows = matches(ballData.Franchise,'DET'); det_data=ballData(det_rows,:);
fla_rows = matches(ballData.Franchise,'FLA'); fla_data=ballData(fla_rows,:);
hou_rows = matches(ballData.Franchise,'HOU'); hou_data=ballData(hou_rows,:);
kcr_rows = matches(ballData.Franchise,'KCR'); kcr_data=ballData(kcr_rows,:);
lad_rows = matches(ballData.Franchise,'LAD'); lad_data=ballData(lad_rows,:);
mil_rows = matches(ballData.Franchise,'MIL'); mil_data=ballData(mil_rows,:);
min_rows = matches(ballData.Franchise,'MIN'); min_data=ballData(min_rows,:);
nym_rows = matches(ballData.Franchise,'NYM'); nym_data=ballData(nym_rows,:);
nyy_rows = matches(ballData.Franchise,'NYY'); nyy_data=ballData(nyy_rows,:);
oak_rows = matches(ballData.Franchise,'OAK'); oak_data=ballData(oak_rows,:);
phi_rows = matches(ballData.Franchise,'PHI'); phi_data=ballData(phi_rows,:);
pit_rows = matches(ballData.Franchise,'PIT'); pit_data=ballData(pit_rows,:);
sdp_rows = matches(ballData.Franchise,'SDP'); sdp_data=ballData(sdp_rows,:);
sea_rows = matches(ballData.Franchise,'SEA'); sea_data=ballData(sea_rows,:);
sfg_rows = matches(ballData.Franchise,'SFG'); sfg_data=ballData(sfg_rows,:);
stl_rows = matches(ballData.Franchise,'STL'); stl_data=ballData(stl_rows,:);
tbd_rows = matches(ballData.Franchise,'TBD'); tbd_data=ballData(tbd_rows,:);
tex_rows = matches(ballData.Franchise,'TEX'); tex_data=ballData(tex_rows,:);
tor_rows = matches(ballData.Franchise,'TOR'); tor_data=ballData(tor_rows,:);
wsn_rows = matches(ballData.Franchise,'WSN'); wsn_data=ballData(wsn_rows,:);

rownonsense={'ana_rows','ari_rows','atl_rows','bal_rows','bos_rows','chc_rows','chw_rows','cin_rows','cle_rows','col_rows','det_rows','fla_rows', 'hou_rows','kcr_rows','lad_rows','mil_rows','min_rows','nym_rows','nyy_rows','oak_rows','phi_rows','pit_rows','sdp_rows','sea_rows','sfg_rows','stl_rows','tbd_rows','tex_rows','tor_rows','wsn_rows'};
clear(rownonsense{:})

ballData = removevars(ballData,"Franchise");


%create all models
logisticModel = fitglm(ballData,'ResponseVar',"WorldSeriesWinner",'Distribution','binomial','LikelihoodPenalty','jeffreys-prior');
stepwiseLogisticModel = stepwiseglm(ballData,'ResponseVar',"WorldSeriesWinner",'Distribution','binomial','LikelihoodPenalty','jeffreys-prior','Verbose',0);
linearModel = fitlm(ballData,"WorldSeriesWinner");
stepwiseModel = stepwiselm(ballData, 'ResponseVar', "WorldSeriesWinner",'Verbose',0);

yap=0;
if yap==1
    disp("Standard Logistic Regression: ")
    disp(logisticModel)
    [p,F]=coefTest(logisticModel)
    disp("----------------------------------------------------")
    disp("Stepwise Logistic Regression: ")
    disp(stepwiseLogisticModel)
    [p,F]=coefTest(stepwiseLogisticModel)
    disp("----------------------------------------------------")
    disp("Standard Linear Regression: ")
    disp(linearModel)
    disp("----------------------------------------------------")
    disp("Stepwise Linear Regression:")
    disp(stepwiseModel)
end

%plots

pictures = 0;
if pictures ==1
    plotSlice(logisticModel)
    plotSlice(stepwiseLogisticModel)
    figure
    plot(linearModel)
    figure
    plot(stepwiseModel)
end

team_datas = table(ana_data, ari_data, atl_data, bal_data, bos_data, chc_data, chw_data, cin_data, cle_data, col_data, det_data, fla_data, hou_data,kcr_data, lad_data, mil_data, min_data, nym_data, nyy_data, oak_data, phi_data, pit_data, sdp_data, sea_data, sfg_data, stl_data, tbd_data, tex_data, tor_data, wsn_data);

%generate probabilities, indexed by year, that a given team will win the world series
% ws_probs = zeros(26,60);
% n=1;
% disp("----------------------------------------------------")
% for x=1:30
%     % head(team_datas.(x).Franchise, 1)
%     ws_probs(:,n)=predict(logisticModel, team_datas.(x)); n=n+1;
%     % disp("----------------------------------------------------")
%     ws_probs(:,n)=predict(stepwiseLogisticModel, team_datas.(x)); n=n+1;
%     % disp("----------------------------------------------------")
% end
% 
% writematrix(ws_probs,'ws_probs.csv')

ballData = removevars(ballData,'WorldSeriesWinner');

logisticModel = fitglm(ballData,'ResponseVar',"LeagueChampion",'Distribution','binomial','LikelihoodPenalty','jeffreys-prior');
stepwiseLogisticModel = stepwiseglm(ballData,'ResponseVar',"LeagueChampion",'Distribution','binomial','LikelihoodPenalty','jeffreys-prior','Verbose',0);
linearModel = fitlm(ballData,"LeagueChampion");
stepwiseModel = stepwiselm(ballData, 'ResponseVar', "LeagueChampion",'Verbose',0);

yap=0;
if yap==2
    disp("Standard Logistic Regression: ")
    disp(logisticModel)
    [p,F]=coefTest(logisticModel)
    disp("----------------------------------------------------")
    disp("Stepwise Logistic Regression: ")
    disp(stepwiseLogisticModel)
    [p,F]=coefTest(stepwiseLogisticModel)
    disp("----------------------------------------------------")
    disp("Standard Linear Regression: ")
    disp(linearModel)
    disp("----------------------------------------------------")
    disp("Stepwise Linear Regression:")
    disp(stepwiseModel)
end

pictures = 0;
if pictures ==2
    figure
    plot(linearModel)
    figure
    plot(stepwiseModel)
end



%generate probability that a given team will win their league by year
% league_probs = zeros(26,60);
% n=1;
% % disp("----------------------------------------------------")
% for x=1:30
%     % head(team_datas.(x).Franchise, 1)
%     league_probs(:,n)=predict(logisticModel, team_datas.(x)); n=n+1;
%     % disp("----------------------------------------------------")
%     league_probs(:,n)=predict(stepwiseLogisticModel, team_datas.(x)); n=n+1;
%     % disp("----------------------------------------------------")
% end
% 
% writematrix(league_probs,'leauge_probs.csv');