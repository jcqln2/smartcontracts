# <span style="color:pink;">Counsel de la mancha Smart Contract </span>

- **Storage**: The `responses` array holds 20 different answers that are written in the style of Don Quixote. Each answer is a string, and the contract uses this array to randomly pick one when a user asks a question.

- **Randomness**: The `askOracle` function creates a pseudo-random number between 0 and 19 by using `keccak256` on the block’s timestamp, the sender’s address (`msg.sender`), and the current block number. It's important to note that this isn’t fully secure for things like betting or financial apps, but it's fine for a fun, non-financial project like this one.

- **Event**: The `QuestionAsked` event is emitted every time a question is asked, logging the user's address and the response they received. This event helps the frontend display the right answer to the user.

- **View Function**: The `getAllResponses` function allows the frontend to access and show all 20 possible responses, so users can see all the answers that the oracle might give.

- **Gas Optimization**: The contract doesn't store any questions on-chain, and it avoids using expensive operations like loops or complex logic. This helps keep gas costs low when interacting with the contract.
