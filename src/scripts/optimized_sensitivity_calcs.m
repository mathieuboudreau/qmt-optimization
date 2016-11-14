[sensitivityOfInterest_B1VFA_SHORT, ~,~,~] = calcSensitivity([0.122 3.97  1/0.9   0.0272 1.096e-05], 'B1_VFA', 'OPT_SHORT_3T.mat');
[sensitivityOfInterest_B1VFA_LONG, ~,~,~] = calcSensitivity([0.122 3.97  1/0.9   0.0272 1.096e-05], 'B1_VFA', 'OPT_LONG_3T.mat');

[sensitivityOfInterest_F_SHORT, ~,~,~] = calcSensitivity([0.122 3.97  1/0.9   0.0272 1.096e-05], [1 0 0 0 0], 'OPT_SHORT_3T.mat');
[sensitivityOfInterest_F_LONG, ~,~,~] = calcSensitivity([0.122 3.97  1/0.9   0.0272 1.096e-05], [1 0 0 0 0], 'OPT_LONG_3T.mat');

[sensitivityOfInterest_kf_SHORT, ~,~,~] = calcSensitivity([0.122 3.97  1/0.9   0.0272 1.096e-05], [0 1 0 0 0], 'OPT_SHORT_3T.mat');
[sensitivityOfInterest_kf_LONG, ~,~,~] = calcSensitivity([0.122 3.97  1/0.9   0.0272 1.096e-05], [0 1 0 0 0], 'OPT_LONG_3T.mat');

%%
%

Sb1vfa = [sensitivityOfInterest_B1VFA_SHORT; sensitivityOfInterest_B1VFA_LONG];
Sf = [sensitivityOfInterest_F_SHORT; sensitivityOfInterest_F_LONG];
Skf = [sensitivityOfInterest_kf_SHORT; sensitivityOfInterest_kf_LONG];

Sb1vfa_n = Sb1vfa./norm(Sb1vfa);
Sf_n = Sf./norm(Sf);
Skf_n = Skf./norm(Skf);

DotFactorF_SL = abs(dot(Sb1vfa_n,Sf_n));
DotFactorkf_SL = abs(dot(Sb1vfa_n,Skf_n));

NormRatioF_SL = norm(Sb1vfa)./norm(Sf);
NormRatio_kf_SL = norm(Sb1vfa)./norm(Skf);

%%
%

Sb1vfa_S = [sensitivityOfInterest_B1VFA_SHORT];
Sf_S = [sensitivityOfInterest_F_SHORT];
Skf_S = [sensitivityOfInterest_kf_SHORT];

Sb1vfa_S_n = Sb1vfa_S./norm(Sb1vfa_S);
Sf_S_n = Sf_S./norm(Sf_S);
Skf_S_n = Skf_S./norm(Skf_S);

DotFactorF_S = abs(dot(Sb1vfa_S_n,Sf_S_n));
DotFactorkf_S = abs(dot(Sb1vfa_S_n,Skf_S_n));

NormRatioF_S = norm(Sb1vfa_S)./norm(Sf_S);
NormRatio_kf_S = norm(Sb1vfa_S)./norm(Skf_S);


%%
%


Sb1vfa_L = [sensitivityOfInterest_B1VFA_LONG];
Sf_L = [sensitivityOfInterest_F_LONG];
Skf_L = [sensitivityOfInterest_kf_LONG];

Sb1vfa_L_n = Sb1vfa_L./norm(Sb1vfa_L);
Sf_L_n = Sf_L./norm(Sf_L);
Skf_L_n = Skf_L./norm(Skf_L);

DotFactorF_L = abs(dot(Sb1vfa_L_n,Sf_L_n));
DotFactorkf_L = abs(dot(Sb1vfa_L_n,Skf_L_n));

NormRatioF_L = norm(Sb1vfa_L)./norm(Sf_L);
NormRatio_kf_L = norm(Sb1vfa_L)./norm(Skf_L);
