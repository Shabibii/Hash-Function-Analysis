%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Title:        Hash Functions Test Harness
% Author:       Samir Habibi (sid1819364)
% Rev. Date:    12/05/2021
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

clear; % delete all variables.
close all; % close all windows.
clc; % clear command window.

% With table sizes 10,100,1000, and so on
% .. the funcion modulus and trunc produce the same values.
% Use prime numbers for better way of hash function examination.
tS = 1009;

numberOfKeys = floor(0.5*tS);  % keep load factor below 0.5

reps = 150 ; % repetitions

% Array pre-allocations
modulusCollision = zeros(1, reps);
midSquareCollision = zeros(1, reps);
truncationCollision = zeros(1, reps);

for i = 1:reps % repeat whole process to evaluate collisions
    
    modulus = zeros(1,numberOfKeys);
    midSquare = zeros(1,numberOfKeys);
    trunc = zeros(1,numberOfKeys);
    
    binM = (1:tS); % create empty array for each index in hash table
    binMS = (1:tS);
    binT = (1:tS);
    
    % keySequential = 10000000;
    
    % For, number of values (keys) to be inserted for hashing
    for N = 1:numberOfKeys        
        for index = 1:N
            
            % Random key of length 8
            keyRandom = randi([10000000; 99999999]);
            
            % Modulus hashing
            modulus(index) = hashMod(keyRandom, tS); 
        
            % Mid square hashing
            midSquare(index) = hashMidSquare(keyRandom,tS); 
  
            % Truncation hashing
            trunc(index) = hashTruncation(keyRandom, tS);
            
            % keySequential = keySequential + 1;

        end       
    end

    %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
    % Modulus: Calculate total collision count(>1) for each run. 
    %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
     
    countM = hist(modulus, binM); % get count of reccuring indices    
    loadM = nonzeros(countM); % get occupied indices    
    
    % Sum total collisions in run (reps)
    % Take away one for each (first is no collision)
    modulusCollision(i) = sum(loadM) - length(loadM);     
    
    %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
    % MidSquare: Calculate total collision count(>1) for each run.
    %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

    countMS = hist(midSquare, binMS);
    loadMS = nonzeros(countMS); 
   
    midSquareCollision(i) = sum(loadMS) - length(loadMS); 

    %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
    % Truncation: Calculate total collision count(>1) for each run.
    %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

    countT = hist(trunc, binT);  
    loadT = nonzeros(countT);      
    
    truncationCollision(i) = sum(loadT) - length(loadT); 
end
  
str = 'Load Factor: ';

% Modulus
loadFactorM = length(loadM)/tS; % calculate load factor    
loadFM = num2str(loadFactorM); % convert to string 
strMod = append(str, loadFM); % fig legend string
meanM = mean(modulusCollision); % get collision mean of all runs
sdM = std(modulusCollision); % get standard deviation of all collisions 
seM = (sdM/sqrt(length(modulusCollision))); % standard error 

% Mid Square
loadFactorMS = length(loadMS)/tS;  
loadFMS = num2str(loadFactorMS);
strMidS = append(str, loadFMS);
meanMS = mean(midSquareCollision); 
sdMS = std(midSquareCollision);
seMS = (sdMS/sqrt(length(midSquareCollision)));

% Truncation
loadFactorT = length(loadT)/tS; 
loadFT = num2str(loadFactorT);
strTrunc = append(str, loadFT);  
meanT = mean(truncationCollision); 
sdT = std(truncationCollision); 
seT = (sdT/sqrt(length(truncationCollision)));

% ttest
[hA,pA,ciA,statsA] = ttest2(modulusCollision,midSquareCollision);
[hB,pB,ciB,statsB] = ttest2(modulusCollision,truncationCollision);
[hC,pC,ciC,statsC] = ttest2(midSquareCollision,truncationCollision);

disp(statsA); % t-value arrays: Modulus, MidSquare
disp(statsB); % t-value arrays: Modulus, Truncation
disp(statsC); % t-value arrays: MidSquare, Truncation

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% PLOT COLLISION BAR CHART (ONE RUN)
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

figProto = figure('Position', get(0, 'Screensize'), 'Color', 'w');
subplot(1, 3, 1); 
bar(countM, 'FaceColor', '#D95319');
title('Modulus Collisions', 'FontSize', 11, 'FontWeight', 'bold');
xlabel('Index', 'FontName', 'Courier', 'FontSize', 10, 'FontWeight',...
    'bold');
ylabel('Collision Count', 'FontName', 'Courier', 'FontSize', 10, ...
    'FontWeight', 'bold');
xlim([0, tS]);ylim([0, max(countM+1)]);
legend(strMod);
axis square;

subplot(1, 3, 2); 
bar(countMS, 'FaceColor', '#0072BD');
title('MidSquare Collisions', 'FontSize', 11, 'FontWeight', 'bold');
xlabel('Index', 'FontName', 'Courier', 'FontSize', 10, 'FontWeight',...
    'bold');
ylabel('Collision Count', 'FontName', 'Courier', 'FontSize', 10, ...
    'FontWeight', 'bold');
xlim([0, tS]);ylim([0, max(countMS+1)]);
legend(strMidS);
axis square;

subplot(1, 3, 3); 
bar(countT, 'FaceColor', '#A2142F');
title('Truncation Collisions', 'FontSize', 11, 'FontWeight', 'bold');
xlabel('Index', 'FontName', 'Courier', 'FontSize', 10, 'FontWeight', ...
    'bold');
ylabel('Collision Count', 'FontName', 'Courier', 'FontSize', 10, ...
    'FontWeight', 'bold');
xlim([0, tS]);ylim([0, max(countT+1)]);
legend(strTrunc);
axis square;

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% PLOT ERROR BARS FOR EACH HASH FUNCTION (COLLISIONS ALL RUNS),
% BASED ON 95% CONFIDENCE INTERVAL
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

figError = figure('Position', get(0, 'Screensize')); 
x = [0, 4]; 
ciLow = [meanM-seM, meanMS-seMS, meanT-seT];
ciHigh = [meanM+seM, meanMS+seMS, meanT+seT];
yMin = (min(ciLow) - 1);
yMax = (max(ciHigh) + 1);
y = [yMin, yMax];
errorbar(1, meanM, seM, 'o', 'MarkerSize', 7, 'MarkerEdgeColor',...
    'black', 'MarkerFaceColor', 'black', 'Color', '#A2142F',...
    'LineWidth', 2, 'CapSize', 20);
hold on;
errorbar(2, meanMS, seMS, '*', 'MarkerSize', 10, 'MarkerEdgeColor',...
    'black', 'Color', '#0072BD', 'LineWidth', 2, 'CapSize', 20);
errorbar(3, meanT, seT, 'd', 'MarkerSize', 7, 'MarkerEdgeColor',...
    'black', 'MarkerFaceColor', 'black', 'Color', '#7E2F8E',...
    'LineWidth', 2, 'CapSize', 20);
title('Error Bars Hash Functions', '95% Confidence Intervals', ...
    'FontSize', 15, 'FontWeight', 'bold');
legend('RED Modulus','BLUE MidSquare', 'PURPLE Truncation');
legend('FontSize', 12);
xlabel('Hash Functions', 'FontName', 'Courier', 'FontSize', 15, ...
    'FontWeight', 'bold');
ylabel('Mean Collisions', 'FontName', 'Courier', 'FontSize', 15, ...
    'FontWeight', 'bold');
xlim(x); ylim(y);
words = {'\bfModulus', '\bfMid Square', '\bfTruncation'};
set(gca,'xtick',[1:3],'xticklabel',words)
str = {'\bfMOD\rm','MEAN:\it' meanM,...
    '\rmSD:\it' sdM,...
    '\rmSEM:\it' seM, '',...
    '\rm\bfMIDSQ\rm','MEAN:\it' meanMS,...
    '\rmSD:\it', sdMS,...
    '\rmSEM:\it' seMS, '',...
    '\rm\bfTRUNC\rm','MEAN:\it' meanT,...
    '\rmSD:\it' sdT,...
    '\rmSEM:\it' seT};
dim = [0.67 0.48 0.3 0.3];
annotation('textbox',dim,'String',str, 'FitBoxToText', 'on');
axis square;
