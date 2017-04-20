clear all
demoProtocol = 'savedprotocols/demo_SPGR_Protocol_for_UnitTest.mat';
demoTissue = [0.122 3.97 1.1111 1 0.0272 1.0960e-05];
protocolObj = SPGR_Protocol(demoProtocol);
tissueObj = SPGR_Tissue(demoTissue);
jacobianObj = SPGR_Jacobian(protocolObj, tissueObj);
computeOpts.mode = 'New';
computeOpts.paramsOfInterest = {'F', 'kf', 'R1f', 'T2r', 'T2f', 'B1_IR', 'B1_VFA'};
computeOpts.lineBuffer = 10;
computeOpts = jacobianObj.compute(computeOpts);