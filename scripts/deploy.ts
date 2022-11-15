import { ethers } from "hardhat";

async function main() {
 

  const Amount = ethers.utils.parseEther("0.01");

  const sendtomany = await ethers.getContractFactory("SendToMany");
  const stmany = await sendtomany.deploy({ value: Amount });

  await stmany.deployed();

  console.log(`Contract deployed to ${stmany.address}`);
}

// We recommend this pattern to be able to use async/await everywhere
// and properly handle errors.
main().catch((error) => {
  console.error(error);
  process.exitCode = 1;
});
