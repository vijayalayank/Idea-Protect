import { useWallet } from '../context/WalletContext.jsx'

const SubmitIdea = () => {
  const { isConnected } = useWallet()

  if (!isConnected) {
    return (
      <div className="card text-center">
        <h1>Submit New Idea</h1>
        <p>Please connect your wallet to submit and protect your ideas.</p>
      </div>
    )
  }

  return (
    <div>
      <h1>Submit New Idea</h1>
      <p>Idea submission form will be implemented here.</p>
    </div>
  )
}

export default SubmitIdea