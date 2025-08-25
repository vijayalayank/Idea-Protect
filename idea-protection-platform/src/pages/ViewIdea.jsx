import { useParams } from 'react-router-dom'

const ViewIdea = () => {
  const { id } = useParams()

  return (
    <div>
      <h1>View Idea {id}</h1>
      <p>Idea details will be displayed here.</p>
    </div>
  )
}

export default ViewIdea