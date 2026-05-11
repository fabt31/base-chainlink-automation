import { ethers } from "ethers";
const REGISTRY = "0xE226D5aCae908252CcA3F6CEFa577527650a9e1f";
const LINK = "0x88Fb150BDc53A65fe94Dea0c9BA0a6dAf8C6e196";
export async function registerUpkeep(upkeepContract: string, name: string, linkAmount: bigint, wallet: ethers.Wallet) {
  const registryAbi = ["function registerUpkeep(address target, uint32 gasLimit, address admin, bytes calldata checkData, bytes calldata offchainConfig) returns (uint256 id)"];
  const linkAbi = ["function approve(address spender, uint256 amount) returns (bool)", "function transferAndCall(address to, uint256 value, bytes calldata data) returns (bool)"];
  const link = new ethers.Contract(LINK, linkAbi, wallet);
  await link.approve(REGISTRY, linkAmount);
  console.log(`Registering upkeep for ${upkeepContract} with ${ethers.formatEther(linkAmount)} LINK`);
}
