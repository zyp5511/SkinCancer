function [IOS] = cal_IOS(label,result)
%CAL_IOL(label,result) Computes the ISO index between binary images of same size
IOS = nnz(label&result)/nnz(result);
end

