const hre = require("hardhat");
const argBonusCrowsaleV1 = require("../../arguments/phase0/BonusCrowsaleV1.js");

async function main() {

    // 1. 建立合約
    const BonusCrowsaleV1 = await hre.ethers.getContractFactory("CappedTimedMaxAmountCrowdsale");

    // 2. 初始化設定
    const bonusCrowsaleV1 = await BonusCrowsaleV1.deploy(...argBonusCrowsaleV1);

    // 3. 佈署合約
    await bonusCrowsaleV1.deployed();

    // 4. 確認地址
    console.log(`BonusCrowsaleV1 deployed to: ${bonusCrowsaleV1.address}\n`);
}

// Hardhat 推薦以這樣的形式呼叫 Main 函數來執行
main()
    .then(() => process.exit(0))
    .catch((error) => {
        console.error(error);
        process.exit(1);
    });


// 0x68109c6B04dB2B12fE2E6335EFE1cEa4030A9a65

/*
require 似乎很花 gas
emit 要在 require 前面
metamask 需要手動改 gas, 合約花 gas 多

轉換成 string 做 eventlog
Strings.toString(xxx)
Strings.toString(boolean ? 1 : 0)




*/