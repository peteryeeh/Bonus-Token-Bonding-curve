const hre = require("hardhat");

async function main() {

    // 1. 建立合約
    const Power = await hre.ethers.getContractFactory("Power");

    await Power.deploy();

    // 2. 初始化設定
    // const power = await Power.deploy();

    // 3. 佈署合約
    // await power.deployed();

    // 4. 確認地址
    console.log(`Crowdsale deployed to: ${power.address}\n`);
}

// Hardhat 推薦以這樣的形式呼叫 Main 函數來執行
main()
    .then(() => process.exit(0))
    .catch((error) => {
        console.error(error);
        process.exit(1);
    });
