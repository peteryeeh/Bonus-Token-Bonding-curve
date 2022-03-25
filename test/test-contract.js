const hre = require("hardhat");

async function main() {

    const contractName = "Greeter";
    const contractAddress = "0x6537fa8Ed07639BBC166cf90A3d950F0cbBf33a0";

    const Greeter = await hre.ethers.getContractAt(contractName, contractAddress);
    console.log(`Live Address: ${Greeter.address}\n`);

    const greet = await Greeter.greet();
    console.log(`Greet: ${greet}\n`);
}

// Hardhat 推薦以這樣的形式呼叫 Main 函數來執行
main()
    .then(() => process.exit(0))
    .catch((error) => {
        console.error(error);
        process.exit(1);
    });
