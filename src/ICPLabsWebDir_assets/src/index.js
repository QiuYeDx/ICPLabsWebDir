import { Actor, HttpAgent } from '@dfinity/agent';
import { idlFactory as ICPLabsWebDir_idl, canisterId as ICPLabsWebDir_id } from 'dfx-generated/ICPLabsWebDir';

const agent = new HttpAgent();
const ICPLabsWebDir = Actor.createActor(ICPLabsWebDir_idl, { agent, canisterId: ICPLabsWebDir_id });

document.getElementById("clickMeBtn").addEventListener("click", async () => {
  const name = document.getElementById("name").value.toString();
  const greeting = await ICPLabsWebDir.greet(name);

  document.getElementById("greeting").innerText = greeting;
});
