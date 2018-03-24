system('perl Formatting.pl');
z = importdata('OUTPUT.txt');
z= transpose(z);
P=z;
[s,t]= size(z);
fprintf('the current dimensionality for histogram is %d\n',s-3);

prompt = ('enter the required dimensionality\n');
k = input(prompt);
[idx,C,sumd, d ] = kmeans(z(4:end,:),k);
[rw, cl]= size(idx);
[row , col] = size(C);
uv = unique(idx);
n  = histc(idx,uv);
new=[];
plot_matt=[];
plot_matt = horzcat(z(4:end,:), idx);

f1 =fopen('Histogram_Reduced_Formatted.txt','w');
f2=fopen('Histogram_New_Dimensions.txt','w');
C= transpose(C);

z= transpose(z);
new= horzcat(z(:,1:3),C);

  fprintf(f1, 'videono frame_no cell_no 1:%d\n',k);
 for ii = 1:col
   
     fprintf(f1,'%g\t\t',new(ii,:));
    fprintf(f1,'\n');
end
 fclose(f1);
 interms=[];
 final_interms =[];
 for i=1:k
 for j=1:rw
if  idx(j)==i
    term=j;
    
    interms = horzcat( interms,term);
end 

 end
 [row_interm , col_interm] = size(interms);
 fprintf(f2, '\nnew dimension %d : ',i);
 fprintf(f2,'<');
for k=1:col_interm
 fprintf(f2, 'old dimension %d=%f ;',interms(1,k),1/col_interm);
end 
 fprintf(f2, ' >');
 interms=[];
 end 

 fclose(f2);
 
 