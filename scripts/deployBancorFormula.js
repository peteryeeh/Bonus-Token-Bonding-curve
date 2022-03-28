const hre = require("hardhat");

async function main() {

    // 1. 建立合約
    const BancorFormula = await hre.ethers.getContractFactory("BancorFormula");

    // 2. 初始化設定
    const bancorFormula = await BancorFormula.deploy();

    // 3. 佈署合約
    await bancorFormula.deployed();

    // 4. 確認地址
    console.log(`BancorFormula deployed to: ${bancorFormula.address}\n`);
}

// Hardhat 推薦以這樣的形式呼叫 Main 函數來執行
main()
    .then(() => process.exit(0))
    .catch((error) => {
        console.error(error);
        process.exit(1);
    });
