const hre = require("hardhat");
const argCurveBondedToken = require("../arguments/CurveBondedToken");

async function main() {

    // 1. 建立合約
    const SimpleCBT = await hre.ethers.getContractFactory("SimpleCBT");

    // 2. 初始化設定
    const simpleCBT = await SimpleCBT.deploy(...argCurveBondedToken);

    // 3. 佈署合約
    await simpleCBT.deployed();

    // 4. 確認地址
    console.log(`simpleCBT deployed to: ${simpleCBT.address}\n`);
}

// Hardhat 推薦以這樣的形式呼叫 Main 函數來執行
main()
    .then(() => process.exit(0))
    .catch((error) => {
        console.error(error);
        process.exit(1);
    });
