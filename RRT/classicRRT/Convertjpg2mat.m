% Conversion script
prompt = 'Input filename to be converted:';
filename = input(prompt,'s');
disp("converting cumston .jpg to .mat file.")
root = 'jpg2mat\';
str = [root,filename];
filepath = join(str);
% filepath = 'jpg2mat\narrow_passage.jpg';
raw = imread(filepath);
custom = double(imbinarize(rgb2gray(raw),0.5));
file = 'custom.mat';
save(file,'-mat', 'custom');
