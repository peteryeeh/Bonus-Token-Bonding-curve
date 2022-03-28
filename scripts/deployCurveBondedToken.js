const hre = require("hardhat");
const argCurveBondedToken = require("../arguments/CurveBondedToken");

async function main() {

    // 1. 建立合約
    const CurveBondedToken = await hre.ethers.getContractFactory("CurveBondedToken");

    // 2. 初始化設定
    const curveBondedToken = await CurveBondedToken.deploy(...argCurveBondedToken);

    // 3. 佈署合約
    await curveBondedToken.deployed();

    // 4. 確認地址
    console.log(`CurveBondedToken deployed to: ${curveBondedToken.address}\n`);
}

// Hardhat 推薦以這樣的形式呼叫 Main 函數來執行
main()
    .then(() => process.exit(0))
    .catch((error) => {
        console.error(error);
        process.exit(1);
    });
