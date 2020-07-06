files = dir('./');

% Filter out any directory/file starting with '.'
for k = length(files):-1:1
    if strcmp(files(k).name(1),'.')
        files(k) = [];
    end
end

isDirectory = [files.isdir];
directories = files(isDirectory);
directoryNames = {directories.name};
numFiles = length(directoryNames);

% Do the first one as a seed
try
    copyfile(fullfile(directoryNames{1},'HCTSA_subset.mat'),'./HCTSA.mat');
catch
    system(sprintf('cp %s ./HCTSA.mat',fullfile(directoryNames{1},'HCTSA_subset.mat')))
end

% Loop through the rest:
for i = 2:numFiles
    newFile = fullfile(directoryNames{i},'HCTSA_subset.mat');
    TS_Combine('HCTSA.mat',newFile,false,false,'HCTSA_combined.mat');
    delete('HCTSA.mat');
    movefile('HCTSA_combined.mat','HCTSA.mat');
end
