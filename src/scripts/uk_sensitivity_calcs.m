[sensitivityOfInterest_B1VFA_UK, ~,~,~] = calcSensitivity([0.122 3.97  1/0.9   0.0272 1.096e-05], 'B1_VFA', 'UK_3T.mat');

[sensitivityOfInterest_B1_UK, ~,~,~] = calcSensitivity([0.122 3.97  1/0.9   0.0272 1.096e-05], 'B1', 'UK_3T.mat');

[sensitivityOfInterest_F_UK, ~,~,~] = calcSensitivity([0.122 3.97  1/0.9   0.0272 1.096e-05], [1 0 0 0 0], 'UK_3T.mat');

[sensitivityOfInterest_kf_UK, ~,~,~] = calcSensitivity([0.122 3.97  1/0.9   0.0272 1.096e-05], [0 1 0 0 0], 'UK_3T.mat');

[sensitivityOfInterest_T2f_UK, ~,~,~] = calcSensitivity([0.122 3.97  1/0.9   0.0272 1.096e-05], [0 0 0 1 0], 'UK_3T.mat');

[sensitivityOfInterest_T2r_UK, ~,~,~] = calcSensitivity([0.122 3.97  1/0.9   0.0272 1.096e-05], [0 0 0 0 1], 'UK_3T.mat');

%%
%
Sb1vfa_UK = [sensitivityOfInterest_B1VFA_UK];
Sb1_UK = [sensitivityOfInterest_B1_UK];
Sf_UK = [sensitivityOfInterest_F_UK];
Skf_UK = [sensitivityOfInterest_kf_UK];
ST2f_UK = [sensitivityOfInterest_T2f_UK];
ST2r_UK = [sensitivityOfInterest_T2r_UK];

Sb1vfa_UK_n = Sb1vfa_UK./norm(Sb1vfa_UK);
Sb1_UK_n = Sb1_UK./norm(Sb1_UK);
Sf_UK_n = Sf_UK./norm(Sf_UK);
Skf_UK_n = Skf_UK./norm(Skf_UK);
ST2f_UK_n = ST2f_UK./norm(ST2f_UK);
ST2r_UK_n = ST2r_UK./norm(ST2r_UK);

DotFactorB1VFA_F_UK = abs(dot(Sb1vfa_UK_n,Sf_UK_n));
DotFactorB1VFA_kf_UK = abs(dot(Sb1vfa_UK_n,Skf_UK_n));
DotFactorB1VFA_T2f_UK = abs(dot(Sb1vfa_UK_n,ST2f_UK_n));
DotFactorB1VFA_T2r_UK = abs(dot(Sb1vfa_UK_n,ST2r_UK_n));

NormRatioB1VFA_F_UK = norm(Sb1vfa_UK)./norm(Sf_UK);
NormRatioB1VFA_kf_UK = norm(Sb1vfa_UK)./norm(Skf_UK);
NormRatioB1VFA_T2f_UK = norm(Sb1vfa_UK)./norm(ST2f_UK);
NormRatioB1VFA_T2r_UK = norm(Sb1vfa_UK)./norm(ST2r_UK);

DotFactorB1_F_UK = abs(dot(Sb1_UK_n,Sf_UK_n));
DotFactorB1_kf_UK = abs(dot(Sb1_UK_n,Skf_UK_n));
DotFactorB1_T2f_UK = abs(dot(Sb1_UK_n,ST2f_UK_n));
DotFactorB1_T2r_UK = abs(dot(Sb1_UK_n,ST2r_UK_n));

NormRatioB1_F_UK = norm(Sb1_UK)./norm(Sf_UK);
NormRatioB1_kf_UK = norm(Sb1_UK)./norm(Skf_UK);
NormRatioB1_T2f_UK = norm(Sb1_UK)./norm(ST2f_UK);
NormRatioB1_T2r_UK = norm(Sb1_UK)./norm(ST2r_UK);

