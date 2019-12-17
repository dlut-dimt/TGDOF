%==========================================================================
% This is the testing code of TGDOF for CS-MRI.If you utilize this code, please cite the related paper: 
% 
% @inproceedings{liu2019theoretically,
%   title={A theoretically guaranteed deep optimization framework for robust compressive sensing mri},
%   author={Liu, Risheng and Zhang, Yuxi and Cheng, Shichao and Fan, Xin and Luo, Zhongxuan},
%   booktitle={Proceedings of the AAAI Conference on Artificial Intelligence},
%   volume={33},
%   pages={4368--4375},
%   year={2019}
% }
% 
% If you have any question, please feel free to contact with <Yuxi Zhang (yuxizhang@mail.dlut.edu.cn)>.
% by Yuxi Zhang (9/2019)
%==========================================================================
clc;
clear all; 
close all;

AddPath

%% Parameters settings
useGPU      = 0;
IterNum     = 50;       % Total iteration numbers,                          default = 50
rho         = 5;         % parameter \rho in module F,                      default = 1.1
MinNet      = 3;        % the weakest artifacts remover in module D,        default = 3     (choose from {1,3,5,7,...,MaxNet})
MaxNet      = 49;       % the strongest artifacts remover in module D,      default = 49    (choose from {MinNet,...,45,47,49})
L           = 1.1;      % parameter \eta in module C and P (\eta = 2/L),    default = 1.1
lambda      = 0.00001;  % parameter \lambda in module C and P,              default = 0.00001


%% Load sampling mask, test data
load('ArtifactsModel.mat');         % load 25 different levels of denoising networks for artifacts removal

mask = load('Radial_20.mat');       % load sampling mask(Gaussian, Radial, Cartesian)
mask = struct2cell(mask);
mask = cell2mat(mask);

label = load('T2w_slice.mat');      % load testing data 
label = struct2cell(label);
label = cell2mat(label);
label = im2double(label);


%% Generate undersampled k-space data
kspace_full = fft2(label);                 
mask        = ifftshift(mask);   
y           = (double(kspace_full)) .* mask ;


%% Generate zero-filled data
input_zf = abs(ifft2(y));  

%% perform reconstruction with TGDOF
res_TGDOF = process_TGDOF(y, mask, input_zf, IterNum, rho, MinNet, MaxNet, ArtifactsModels, L, lambda, useGPU);
imshow(abs(res_TGDOF))
re_PSnr = psnr(abs(res_TGDOF) , abs(label))











