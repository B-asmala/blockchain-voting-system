# Timed Voting System Using a Smart Contract
I used [Remix IDE](https://remix.ethereum.org/) for compiling and deployment.

I Also took some [notes](notes.md) for future reference.

After compiling, I deployed the smart contract, passed in the number of minutes allowed for voting, and the candidates.

![](images/sc_1.png)

The contract was deployed successfully, and started executing and the timer was started.

![](images/sc_2.png)
![](images/sc_3.png)

We can vote by entering the candidate index

![](images/sc_4.png)

Voted successfully

![](images/sc_5.png)

We can check the cadidate with the highest current votes :

![](images/sc_6.png)

But if we try to vote again from the same account, it doesn't work. Only one time is allowed for each account.

![](images/sc_7.png)

We can choose another account and vote, this works fine.

![](images/sc_8.png)

to know time left till the deadline we can use :

![](images/sc_9.png)

If we try to vote after the deadline was reached, it is not allowed 

![](images/sc_10.png)

That's for now, I will be adding new features later :D
