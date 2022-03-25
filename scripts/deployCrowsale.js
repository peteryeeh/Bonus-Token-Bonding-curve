const hre = require("hardhat");
const argCrowdsale = require("../arguments/Crowdsale");

async function main() {

    // 1. 建立合約
    const Crowdsale = await hre.ethers.getContractFactory("Crowdsale");

    // 2. 初始化設定
    const crowdsale = await Crowdsale.deploy(...argCrowdsale);

    // 3. 佈署合約
    await crowdsale.deployed();

    // 4. 確認地址
    console.log(`Crowdsale deployed to: ${crowdsale.address}\n`);
}

// Hardhat 推薦以這樣的形式呼叫 Main 函數來執行
main()
    .then(() => process.exit(0))
    .catch((error) => {
        console.error(error);
        process.exit(1);
    });
