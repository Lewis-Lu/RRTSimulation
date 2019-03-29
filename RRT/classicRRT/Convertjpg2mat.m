function map = Convertjpg2mat
    prompt = 'Please Input JPG name:';
    jpgname = input(prompt, 's');
    whos filename
    raw = imread(jpgname);
    mat = double(imbinarize(rgb2gray(raw),0.5));
    save test.mat mat
    map = load('test.mat');
end