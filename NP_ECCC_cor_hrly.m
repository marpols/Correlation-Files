%read files. Data should start on same day of year, contain same number of
%rows.
data_ECCC = readtable('compiled_data_MP.csv');
data_NP = importdata('POWER_Point_Hourly_20010101_20211231_046d3000N_063d5800W_LST.csv',',',15);
output_file_name = "maple_plains_hourly_correlations.txt"; %title of file output

ECCC_mod = data_ECCC(5:end, [6:9 14 20]); %edited b/c NP data started at 01/01/2001 4:00 for some reason
ECCC_RH = str2double(ECCC_mod{:,5}); %column of ECCC hourly RH values
ECCC_WS = str2double(ECCC_mod{:,6}); %column of ECCC hourly WS (@10m) values

%correlation between all data
overall_cor_RH = corrcoef(ECCC_RH,data_NP.data(:,5),'row','complete');
overall_cor_WS = corrcoef(ECCC_RH,data_NP.data(:,6),'row','complete');

%write to file
fileID = fopen(output_file_name,'w');
fprintf(fileID,'%8s %6.4f\n','overall correlation RH',overall_cor_RH(1,2));
fprintf(fileID,'%8s %6.4f\n','overall correlation WS',overall_cor_WS(1,2));
fclose(fileID);



        

    