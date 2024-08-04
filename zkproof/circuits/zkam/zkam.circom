pragma circom 2.0.0;

include "../node_modules/circomlib/circuits/poseidon.circom";
include "./helpers/hasher.circom";
template ZKam(size) {
    
    signal input imageWithHash[size];
    signal input hashIndexs[256];

    var originalHash[256];
    var originalImage[size];
    signal output hashOutput; 

    for (var i = 0; i < size; i++) {
        originalImage[i] = imageWithHash[i];
    }

    for (var i = 0; i < 256; i++) {
        originalHash[i] = imageWithHash[hashIndexs[i]];
        originalImage[hashIndexs[i]] = 0;
    }

    var test = 0;
    for (var i = 0; i < size; i++) {
        test = (test << 1) | originalImage[i];
    }
    component hasher = Poseidon(1);
    hasher.inputs[0] <== test;

    // hashOutput <== (hasher.out == test);
}

component main {public [imageWithHash, hashIndexs]} = ZKam(300 * 300);