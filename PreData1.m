% Preprocessing Data

%% clear command windows
clc
% clear all
% close all
%% label raw data(unlabeled data)
% read in raw data
fid = fopen('RawData4.txt', 'r');
patient = {};
feature = {};
flag_read = false;
while 1
    tline = fgetl(fid);
    if ~ischar(tline)
        break;
    end
    
    if flag_read
        fs_str = strsplit(tline);
        fs_num(1) = str2double(fs_str{1});
        fs_num(2) = str2double(fs_str{2});
        fs_num(3) = str2double(fs_str{3});
        feature = [feature, {fs_num}];
    else
        patient = [patient, {tline}];
    end
    
    flag_read = ~flag_read;
end
fclose(fid);

% read in label from excel
[NUM, TXT, RAW] = xlsread('tcia-diagnosis-data-2012-04-20.xls','Diagnosis Truth');

% add label to raw data
fid = fopen('LabelData5.txt', 'w');
posi=0
% for i = 2:length(patient)
%     
%     if (find(ismember(TXT, patient{i})))
%         % cancer positive
%        
%         fprintf(fid, '%s\n', patient{i});
%         feature{i} = [feature{i}, 1];
%         fprintf(fid, '%f %f %f %f\n', feature{i});
%     else
%         % cancer negative
%          if posi>150
%             continue
%         end
%         posi=posi+1;
%         fprintf(fid, '%s\n', patient{i});
%         feature{i} = [feature{i}, 0];
%         fprintf(fid, '%f %f %f %f\n', feature{i});
%     end
%     
% end
for i = 1:length(patient)
    fprintf(fid, '%s\n', patient{i});
    if find(ismember(TXT, patient{i}))
        % cancer positive
        feature{i} = [feature{i}, 1];
    else
        % cancer negative
        feature{i} = [feature{i}, 0];
    end
    fprintf(fid, '%f %f %f %f\n', feature{i});
end
fclose(fid);