import { Link, useLocation } from 'react-router-dom'
import { useWallet } from '../context/WalletContext.jsx'

const Header = () => {
  const { account, isConnected, connectWallet, disconnectWallet, isConnecting } = useWallet()
  const location = useLocation()

  const formatAddress = (address) => {
    if (!address) return ''
    return `${address.slice(0, 6)}...${address.slice(-4)}`
  }

  const isActive = (path) => {
    return location.pathname === path
  }

  return (
    <header className="header">
      <div className="header-content">
        <Link to="/" className="logo">
          💡 Idea Vault
        </Link>
        
        <nav className="nav">
          <Link 
            to="/" 
            className={`nav-link ${isActive('/') ? 'active' : ''}`}
          >
            Dashboard
          </Link>
          <Link 
            to="/submit" 
            className={`nav-link ${isActive('/submit') ? 'active' : ''}`}
          >
            Submit Idea
          </Link>
          <Link 
            to="/marketplace" 
            className={`nav-link ${isActive('/marketplace') ? 'active' : ''}`}
          >
            Marketplace
          </Link>
          
          <div className="flex items-center gap-4">
            {!isConnected ? (
              <button 
                onClick={connectWallet}
                className="btn btn-primary"
                disabled={isConnecting}
              >
                {isConnecting ? (
                  <>
                    <span className="loading"></span>
                    Connecting...
                  </>
                ) : (
                  'Connect Wallet'
                )}
              </button>
            ) : (
              <div className="flex items-center gap-4">
                <span className="nav-link">
                  {formatAddress(account)}
                </span>
                <button 
                  onClick={disconnectWallet}
                  className="btn btn-secondary"
                >
                  Disconnect
                </button>
              </div>
            )}
          </div>
        </nav>
      </div>
    </header>
  )
}

export default Header