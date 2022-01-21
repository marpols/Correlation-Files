%read files. Data should start on same day of year.
data_ECCC = readtable('new_glasgow_data.csv');
data_NP = importdata('new_glasgow_NP3.csv',',',15);


%Calculate Coefficients for each growing season:
coeffs = [];
may_start = 0;
Mfirst_int = 0;
oct_end = 0;
Ofirst_int = 0;
%select variables to be compared (column number in data tables)
NP_var = 6;
ECCC_var = 7;
month_col = 3;

for i = 1:height(data_ECCC)
    if data_ECCC{i,month_col} == 5 & Mfirst_int == 0
        may_start = i;
        Mfirst_int = 1;
        Ofirst_int = 0;
    end
    if data_ECCC{i,month_col} == 11 & Ofirst_int == 0
        oct_end = i - 1;
        %find correlation
        a = data_NP.data(may_start:oct_end,NP_var);
        b = data_ECCC{may_start:oct_end,ECCC_var};
        R = corrcoef(a,b,'Rows','complete');
        %add correlation coef. for that year's growing season to coeffs
        %matrix
        new_row = [data_ECCC{i,2};R(1,2)];
        coeffs = [coeffs;new_row]; %concat w/ coeffs matrix
        Ofirst_int = 1; 
        Mfirst_int = 0;
    end
end
%correlation between all data
corrcoef(data_ECCC{:,ECCC_var},data_NP.data(1:11203,NP_var),'row','complete')

        

    