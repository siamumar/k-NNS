clc
clear all
close all

N = 64;
k = 8;

% W = 32;
% M = 2^W-1;
% q = int32(M*rand(1, 2)-M/2);
% S = int32(M*rand(N, 2)-M/2);
% save ('dist_lib.mat', 'S', 'q');
% 
% fid = fopen('dist_lib.txt', 'wt');
% fprintf(fid, '%d \n%d \n', q(1), q(2));
% for n = 1:N
%     fprintf(fid, '%d \n%d \n', S(n, 1), S(n, 2));
% end
% fclose (fid);
% 
% fid = fopen('dist_lib_verilog_tb.txt', 'wt');
% fprintf(fid, 'x1 = %d; \ny1 = %d; \n', q(1), q(2));
% for n = 1:N
%     fprintf(fid, 'x2 = %d; \ny2 = %d; \n#100; \n', S(n, 1), S(n, 2));
% end
% fclose (fid);

load 'dist_lib.mat';

R = k_NNS(S, q, k);

figure, hold on
plot(q(1), q(2), 'ks')
for n = 1:N
    plot(S(n,1), S(n, 2), 'bx')
end
for n = 1:k
    plot(R(n,1), R(n, 2), 'ro')
end

disp(R)