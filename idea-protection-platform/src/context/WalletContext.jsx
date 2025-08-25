import { createContext, useContext, useState } from 'react'

const WalletContext = createContext()

export const useWallet = () => {
  const context = useContext(WalletContext)
  if (!context) {
    throw new Error('useWallet must be used within a WalletProvider')
  }
  return context
}

export const WalletProvider = ({ children }) => {
  const [account, setAccount] = useState(null)
  const [isConnected, setIsConnected] = useState(false)
  const [isConnecting, setIsConnecting] = useState(false)

  const connectWallet = async () => {
    setIsConnecting(true)
    // Mock connection for now
    setTimeout(() => {
      setAccount('0x1234...5678')
      setIsConnected(true)
      setIsConnecting(false)
    }, 1000)
  }

  const disconnectWallet = () => {
    setAccount(null)
    setIsConnected(false)
  }

  const value = {
    account,
    isConnected,
    isConnecting,
    connectWallet,
    disconnectWallet
  }

  return (
    <WalletContext.Provider value={value}>
      {children}
    </WalletContext.Provider>
  )
}