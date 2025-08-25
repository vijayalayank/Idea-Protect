import { BrowserRouter as Router, Routes, Route } from 'react-router-dom'
import Header from './components/Header.jsx'
import Dashboard from './pages/Dashboard.jsx'
import SubmitIdea from './pages/SubmitIdea.jsx'
import Marketplace from './pages/Marketplace.jsx'
import ViewIdea from './pages/ViewIdea.jsx'
import { WalletProvider } from './context/WalletContext.jsx'

export default function App() {
  return (
    <WalletProvider>
      <Router>
        <div className="app">
          <Header />
          <main className="main-content">
            <Routes>
              <Route path="/" element={<Dashboard />} />
              <Route path="/submit" element={<SubmitIdea />} />
              <Route path="/marketplace" element={<Marketplace />} />
              <Route path="/idea/:id" element={<ViewIdea />} />
            </Routes>
          </main>
        </div>
      </Router>
    </WalletProvider>
  )
}