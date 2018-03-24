clear;
clc;
system('perl Formatting.pl');
fprintf('Reading file....\n');
Z = importdata('OUTPUT.txt');
fprintf('File Read\n\n');
[noOfCells, information] = size(Z);
[coeff, score, latent] = pca(Z(:,4:end));
fprintf('Number of dimensions in original file is- %d \n\n', (information-3));
%varianceValue = cumsum(var(score)) / sum(var(score));
d = input('Enter the targetted dimensionality \n');
newDimensions = coeff(:,1:d);
finalMatrix= [Z(:,1:3) score(:,1:d)];
fileID = fopen('Histogram_Reduced_Formatted.txt', 'w');
fprintf(fileID, '<Video; Frame; Cell; ');
for k=1:d
    fprintf(fileID, 'nd-%d; ',k);
end
fprintf(fileID, '>\r\n');

for i=1:size(Z,1)
    fprintf(fileID, '<');
  fprintf(fileID, ' %d;', finalMatrix(i,:));
  fprintf(fileID, '>\r\n');
end
fileNewDimensions = fopen('Histogram_New_Dimensions.txt', 'w');

for i=1:d
    tempDim = newDimensions(:, i);
    [val, ind] = sort(tempDim, 'descend');
    fprintf(fileNewDimensions, 'New Dimension- %d = <', i);
    for j=1:size(val,1)
        fprintf(fileNewDimensions, 'od%d = %f; ', ind(j,1),val(j,1));
    end
    fprintf(fileNewDimensions, '> \r\n\r\n');
end
