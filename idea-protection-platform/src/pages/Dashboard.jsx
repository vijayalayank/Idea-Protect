import { useWallet } from '../context/WalletContext.jsx'

const Dashboard = () => {
  const { isConnected } = useWallet()

  if (!isConnected) {
    return (
      <div className="card text-center">
        <h1>Welcome to Idea Vault</h1>
        <p>Connect your MetaMask wallet to get started!</p>
      </div>
    )
  }

  return (
    <div>
      <h1>My Ideas Dashboard</h1>
      <p>Your protected ideas will appear here.</p>
    </div>
  )
}

export default Dashboard