# Basic Sample Hardhat Project

這是 TraderDAO 的募資認購 (Crowdsale) 智能合約專案 (Solidity 0.8.0)

以 [OpenZeppelin/openzeppelin-contracts](https://github.com/OpenZeppelin/openzeppelin-contracts) v2.5 版本 (Solidity 0.4.24) 的 Crowsale 合約為基礎，調整成 TraderDAO 所需的合約。因為 openzeppelin-contracts 在 v3.0 以後的版本以不再支援，主要原因是 Solidity 在 0.6 版本的升級，更多請見 [Crowdsales v3.x (openzeppelin.com)](https://docs.openzeppelin.com/contracts/3.x/crowdsales)

## 注意事項

- 所有檔案中預設網路都是 Polygon Mainnet (Polygon 主網), 佈署時會有費用
- 所有合約都沒有經過嚴格的測試與審計，使用上請注意風險，造成損失概不負責

## 快速開始

安裝套件：

```
npm install
```

安裝完之後，在本目錄下開一個 `.env` 檔案放入以下資料：
- `ACCOUNT_ADDRESS`: 佈署人帳戶地址
- `PRIVATE_KEY`: 佈署人帳戶私鑰
- `INFURA_API_KEY`: 佈署人 Infura 地址
- `POLYGONSCAN_API_KEY`: 佈署人 Polygonscan 的 API 金鑰

```
ACCOUNT_ADDRESS=0xXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX
PRIVATE_KEY=abcdexxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx12345
INFURA_API_KEY=xyzxxxxxxxxxxxxxxxxxxxxxxxxxx456
POLYGONSCAN_API_KEY=ABCxxxxxxxxxxxxxxxxxxxxxxxxxxxxXYZ
                    
```

## 開啟 Hardhat 測試網路

透過開啟測試節網路，會有免費的帳號和私鑰進行測試

```
npx hardhat node
```

## 佈署到 Polygon 網路

```
npx hardhat run scripts/deployXXXXX.js --network matic
```

### 在 Polygonscan 上驗證合約

為了讓所有人都能看到 TraderDAO 公開透明的智能合約，我們需要驗證並公開合約內容
請記得將佈署時的參數，分開儲存到 `arguments/` 資料夾下，並透過標籤 `-constructor-args` 引入

```
npx hardhat verify <合約地址> --network matic --constructor-args arguments/XXXXX.js
```

## LICENSE

MIT License