[sensitivityOfInterest_B1VFA_SHORT, ~,~,~] = calcSensitivity([0.122 3.97  1/0.9   0.0272 1.096e-05], 'B1_VFA', 'OPT_SHORT_3T.mat');
[sensitivityOfInterest_B1VFA_LONG, ~,~,~] = calcSensitivity([0.122 3.97  1/0.9   0.0272 1.096e-05], 'B1_VFA', 'OPT_LONG_3T.mat');

[sensitivityOfInterest_B1_SHORT, ~,~,~] = calcSensitivity([0.122 3.97  1/0.9   0.0272 1.096e-05], 'B1', 'OPT_SHORT_3T.mat');
[sensitivityOfInterest_B1_LONG, ~,~,~] = calcSensitivity([0.122 3.97  1/0.9   0.0272 1.096e-05], 'B1', 'OPT_LONG_3T.mat');

[sensitivityOfInterest_F_SHORT, ~,~,~] = calcSensitivity([0.122 3.97  1/0.9   0.0272 1.096e-05], [1 0 0 0 0], 'OPT_SHORT_3T.mat');
[sensitivityOfInterest_F_LONG, ~,~,~] = calcSensitivity([0.122 3.97  1/0.9   0.0272 1.096e-05], [1 0 0 0 0], 'OPT_LONG_3T.mat');

[sensitivityOfInterest_kf_SHORT, ~,~,~] = calcSensitivity([0.122 3.97  1/0.9   0.0272 1.096e-05], [0 1 0 0 0], 'OPT_SHORT_3T.mat');
[sensitivityOfInterest_kf_LONG, ~,~,~] = calcSensitivity([0.122 3.97  1/0.9   0.0272 1.096e-05], [0 1 0 0 0], 'OPT_LONG_3T.mat');

[sensitivityOfInterest_T2f_SHORT, ~,~,~] = calcSensitivity([0.122 3.97  1/0.9   0.0272 1.096e-05], [0 0 0 1 0], 'OPT_SHORT_3T.mat');
[sensitivityOfInterest_T2f_LONG, ~,~,~] = calcSensitivity([0.122 3.97  1/0.9   0.0272 1.096e-05], [0 0 0 1 0], 'OPT_LONG_3T.mat');

[sensitivityOfInterest_T2r_SHORT, ~,~,~] = calcSensitivity([0.122 3.97  1/0.9   0.0272 1.096e-05], [0 0 0 0 1], 'OPT_SHORT_3T.mat');
[sensitivityOfInterest_T2r_LONG, ~,~,~] = calcSensitivity([0.122 3.97  1/0.9   0.0272 1.096e-05], [0 0 0 0 1], 'OPT_LONG_3T.mat');

%%
%

Sb1vfa = [sensitivityOfInterest_B1VFA_SHORT; sensitivityOfInterest_B1VFA_LONG];
Sb1 = [sensitivityOfInterest_B1_SHORT; sensitivityOfInterest_B1_LONG];
Sf = [sensitivityOfInterest_F_SHORT; sensitivityOfInterest_F_LONG];
Skf = [sensitivityOfInterest_kf_SHORT; sensitivityOfInterest_kf_LONG];
ST2f = [sensitivityOfInterest_T2f_SHORT; sensitivityOfInterest_T2f_LONG];
ST2r = [sensitivityOfInterest_T2r_SHORT; sensitivityOfInterest_T2r_LONG];

Sb1vfa_n = Sb1vfa./norm(Sb1vfa);
Sb1_n = Sb1./norm(Sb1);
Sf_n = Sf./norm(Sf);
Skf_n = Skf./norm(Skf);
ST2f_n = ST2f./norm(ST2f);
ST2r_n = ST2r./norm(ST2r);

DotFactorB1VFA_F_SL = abs(dot(Sb1vfa_n,Sf_n));
DotFactorB1VFA_kf_SL = abs(dot(Sb1vfa_n,Skf_n));
DotFactorB1VFA_T2f_SL = abs(dot(Sb1vfa_n,ST2f_n));
DotFactorB1VFA_T2r_SL = abs(dot(Sb1vfa_n,ST2r_n));

NormRatioB1VFA_F_SL = norm(Sb1vfa)./norm(Sf);
NormRatioB1VFA_kf_SL = norm(Sb1vfa)./norm(Skf);
NormRatioB1VFA_T2f_SL = norm(Sb1vfa)./norm(ST2f);
NormRatioB1VFA_T2r_SL = norm(Sb1vfa)./norm(ST2r);

DotFactorB1_F_SL = abs(dot(Sb1_n,Sf_n));
DotFactorB1_kf_SL = abs(dot(Sb1_n,Skf_n));
DotFactorB1_T2f_SL = abs(dot(Sb1_n,ST2f_n));
DotFactorB1_T2r_SL = abs(dot(Sb1_n,ST2r_n));

NormRatioB1_F_SL = norm(Sb1)./norm(Sf);
NormRatioB1_kf_SL = norm(Sb1)./norm(Skf);
NormRatioB1_T2f_SL = norm(Sb1)./norm(ST2f);
NormRatioB1_T2r_SL = norm(Sb1)./norm(ST2r);

%%
%
Sb1vfa_S = [sensitivityOfInterest_B1VFA_SHORT];
Sb1_S = [sensitivityOfInterest_B1_SHORT];
Sf_S = [sensitivityOfInterest_F_SHORT];
Skf_S = [sensitivityOfInterest_kf_SHORT];
ST2f_S = [sensitivityOfInterest_T2f_SHORT];
ST2r_S = [sensitivityOfInterest_T2r_SHORT];

Sb1vfa_S_n = Sb1vfa_S./norm(Sb1vfa_S);
Sb1_S_n = Sb1_S./norm(Sb1_S);
Sf_S_n = Sf_S./norm(Sf_S);
Skf_S_n = Skf_S./norm(Skf_S);
ST2f_S_n = ST2f_S./norm(ST2f_S);
ST2r_S_n = ST2r_S./norm(ST2r_S);

DotFactorB1VFA_F_S = abs(dot(Sb1vfa_S_n,Sf_S_n));
DotFactorB1VFA_kf_S = abs(dot(Sb1vfa_S_n,Skf_S_n));
DotFactorB1VFA_T2f_S = abs(dot(Sb1vfa_S_n,ST2f_S_n));
DotFactorB1VFA_T2r_S = abs(dot(Sb1vfa_S_n,ST2r_S_n));

NormRatioB1VFA_F_S = norm(Sb1vfa_S)./norm(Sf_S);
NormRatioB1VFA_kf_S = norm(Sb1vfa_S)./norm(Skf_S);
NormRatioB1VFA_T2f_S = norm(Sb1vfa_S)./norm(ST2f_S);
NormRatioB1VFA_T2r_S = norm(Sb1vfa_S)./norm(ST2r_S);

DotFactorB1_F_S = abs(dot(Sb1_S_n,Sf_S_n));
DotFactorB1_kf_S = abs(dot(Sb1_S_n,Skf_S_n));
DotFactorB1_T2f_S = abs(dot(Sb1_S_n,ST2f_S_n));
DotFactorB1_T2r_S = abs(dot(Sb1_S_n,ST2r_S_n));

NormRatioB1_F_S = norm(Sb1_S)./norm(Sf_S);
NormRatioB1_kf_S = norm(Sb1_S)./norm(Skf_S);
NormRatioB1_T2f_S = norm(Sb1_S)./norm(ST2f_S);
NormRatioB1_T2r_S = norm(Sb1_S)./norm(ST2r_S);


%%
%

Sb1vfa_L = [sensitivityOfInterest_B1VFA_LONG];
Sb1_L = [sensitivityOfInterest_B1_LONG];
Sf_L = [sensitivityOfInterest_F_LONG];
Skf_L = [sensitivityOfInterest_kf_LONG];
ST2f_L = [sensitivityOfInterest_T2f_LONG];
ST2r_L = [sensitivityOfInterest_T2r_LONG];

Sb1vfa_L_n = Sb1vfa_L./norm(Sb1vfa_L);
Sb1_L_n = Sb1_L./norm(Sb1_L);
Sf_L_n = Sf_L./norm(Sf_L);
Skf_L_n = Skf_L./norm(Skf_L);
ST2f_L_n = ST2f_L./norm(ST2f_L);
ST2r_L_n = ST2r_L./norm(ST2r_L);

DotFactorB1VFA_F_L = abs(dot(Sb1vfa_L_n,Sf_L_n));
DotFactorB1VFA_kf_L = abs(dot(Sb1vfa_L_n,Skf_L_n));
DotFactorB1VFA_T2f_L = abs(dot(Sb1vfa_L_n,ST2f_L_n));
DotFactorB1VFA_T2r_L = abs(dot(Sb1vfa_L_n,ST2r_L_n));

NormRatioB1VFA_F_L = norm(Sb1vfa_L)./norm(Sf_L);
NormRatioB1VFA_kf_L = norm(Sb1vfa_L)./norm(Skf_L);
NormRatioB1VFA_T2f_L = norm(Sb1vfa_L)./norm(ST2f_L);
NormRatioB1VFA_T2r_L = norm(Sb1vfa_L)./norm(ST2r_L);

DotFactorB1_F_L = abs(dot(Sb1_L_n,Sf_L_n));
DotFactorB1_kf_L = abs(dot(Sb1_L_n,Skf_L_n));
DotFactorB1_T2f_L = abs(dot(Sb1_L_n,ST2f_L_n));
DotFactorB1_T2r_L = abs(dot(Sb1_L_n,ST2r_L_n));

NormRatioB1_F_L = norm(Sb1_L)./norm(Sf_L);
NormRatioB1_kf_L = norm(Sb1_L)./norm(Skf_L);
NormRatioB1_T2f_L = norm(Sb1_L)./norm(ST2f_L);
NormRatioB1_T2r_L = norm(Sb1_L)./norm(ST2r_L);
