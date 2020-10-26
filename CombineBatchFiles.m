% CombineBatchFiles
%-------------------------------------------------------------------------------
% Script to loop through directories from a distributed batch computation (across
% ranges of tsids) and combine results into a single HCTSA.mat file.
%-------------------------------------------------------------------------------
% Directories are produced by a HCTSA_run.sh script, in the form "tsids_X-Y"
% for a range of ts_ids from X to Y.
%===============================================================================

files = dir('./');

% Filter out any directories/files starting with '.'
for k = length(files):-1:1
    if strcmp(files(k).name(1),'.')
        files(k) = [];
    end
end

% Retrieve all directories
isDirectory = [files.isdir];
directories = files(isDirectory);
directoryNames = {directories.name};
numFiles = length(directoryNames);

% Sort by tsids:
ts_IDs = extractBetween(directoryNames,'tsids_','-');
ts_IDs = cellfun(@str2num,ts_IDs,'UniformOutput',true);
[~,ix] = sort(ts_IDs,'ascend');
directoryNames = directoryNames(ix);

% Copy the first one as a seed for others to combine into
try
    copyfile(fullfile(directoryNames{1},'HCTSA_subset.mat'),'./HCTSA.mat');
catch
    system(sprintf('cp %s ./HCTSA.mat',fullfile(directoryNames{1},'HCTSA_subset.mat')))
end

% Loop through the rest:
for f = 2:numFiles
    newFile = fullfile(directoryNames{f},'HCTSA_subset.mat');
    TS_Combine('HCTSA.mat',newFile,false,false,'HCTSA_combined.mat');
    delete('HCTSA.mat');
    movefile('HCTSA_combined.mat','HCTSA.mat');
end
