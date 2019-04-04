%%
%THIS code borrowed serveral repos from Github

clear all
close all

labels = read_images_png('C:\Users\zyp\Downloads\ISIC2018_Task1_Training_GroundTruth');
images = read_images('C:\Users\zyp\Downloads\ISIC2018_Task1-2_Training_Input');

sub_index = 1:2594; %% you can choose to shuffle here
Ios_all = zeros(1,2594);
jotsu_all = zeros(1,2594);
for i = 1:2594
  %% Segmentation
    sub_index(i);
    fn_all = split(images(sub_index(i)).name,'.');
    img_folder = images(sub_index(i)).folder;
    label_folder = labels(sub_index(i)).folder;
    [jotsu,IOS] = segment_display(img_folder,label_folder,fn_all{1});
    Ios_all(i)=IOS;
    jotsu_all(i)=jotsu;

 %% Generating MASK
%     mask= uint8(repmat(label_i,[1 1 3]));
%     c = mask/255.*image_i;
%     im_mask = label_i;
%     
%     image_name = images(sub_index(i)).name;
%     image_name_array = split(image_name,".");
%     file_location = strcat('label_result','/',image_name_array{1});
%     masked_im_name = strcat(file_location,'masked.', image_name_array{2});
%     mask_im_name = strcat(file_location,'/',image_name_array{1}, '_1.tif');
%     mkdir(file_location)
%     imwrite(c,masked_im_name);
%     imwrite(~im_mask,mask_im_name);
%     
%     th = 4;
%     [split_result,split_mask] = even_splite_4(c,im_mask,th);
%     temp_mask = ~im_mask;
%     for j = 1:th-1
%         %subplot(2,(th-1),i)
%         mask_A = split_mask{j};
%         temp_mask = ~mask_A + temp_mask;
%         mask_im_name = strcat(file_location,'/',image_name_array{1},'_',num2str(j+1),'.tif');
%         imwrite(temp_mask,mask_im_name);
%         %title("split by 3 after local hist eq")
%         %subplot(2,(th-1),i+th-1)
%         %imshow(split_mask{i})
%         %title("MASK")
%     end
    
end

figure
hist(Ios_all)
title('IOS over 2594 images')
figure
hist(jotsu_all)
title('jaccard over 2594 images')

hist(jotsu_all+Ios_all)

