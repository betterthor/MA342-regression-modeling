disp("Saab Only: ")
saabData = readtable('saabData.csv');
saabData = removevars(saabData,["Model", "Type"]);

disp("Standard Linear Regression: ")
saabLinearModel = fitlm(saabData,"Price")

disp("----------------------------------------------------")

disp("Stepwise Linear Regression:")
saabStepwiseModel = stepwiselm(saabData, 'ResponseVar', "Price", 'Upper','linear')

% figure
% plot(saabLinearModel)
% figure
% plot(saabStepwiseModel)



disp("----------------------------------------------------")

disp("All cars: ")
carData =readtable('carData.csv');
carData =removevars(carData,["Make","Model","Type"]);

disp("Standard Linear Regression: ")
linearModel = fitlm(carData,"Price")

disp("----------------------------------------------------")

disp("Stepwise Linear Regression:")
stepwiseModel = stepwiselm(carData, 'ResponseVar', "Price")

% figure
% plot(linearModel)
% figure
% plot(stepwiseModel)