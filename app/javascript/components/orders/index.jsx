import React from 'react'
import ReactDOM from 'react-dom'
import PropTypes from 'prop-types'

const Index = props => {
  let unshippedOders = props.unshipped_orders
  let shippedOrders = props.shipped_orders

  return (
  <div className='manage-table pt-5'>
    <div className='container'>
      <h1 className='mb-1'>Orders |
        <a href='/manage/orders'>
          <i className='bi bi-pencil-square'></i>
        </a>
      </h1>
      <div className='row col-md-6 col-md-offset-2 cutstyle'></div>

      <h3 className='mb-1 mt-3'> Unshipped Orders</h3>
      <table className='table table-striped custab'>
        <tr>
          <th>Name</th>
          <th>Email</th>
          <th>Phone</th>
          <th>Amount</th>
          <th>Address</th>
          <th>UUID</th>
          <th>Status</th>
          <th>Action</th>
          <th></th>
          <th></th>
          <th></th>
        </tr>
        <tbody>
          {
            unshippedOders.map(order => {
              return (
                <tr>
                  <td>{`${order.first_name} ${order.last_name}`}</td>
                  <td>{order.email}</td>
                  <td>{order.phone}</td>
                  <td>{order.amount}</td>
                  <td>{`${order.address1} ${order.address2}, ${order.city}, ${order.region} ${order.postal_code}`}</td>
                  <td>{order.uuid}</td>
                  <td>{order.shipped ? 'Shipped' : 'Not Shipped'}</td>
                  <td><a href="">Updated Status</a></td>
                  <td><a href={'/manage/orders/' + order.uuid}>Show</a></td>
                  <td><a href={'/manage/orders/' + order.uuid + '/edit'}>Edit</a></td>
                  <td><a href="">Destroy</a></td>
                </tr>
              )
            })
          }
        </tbody>
      </table>

      <h3 className='mb-1 mt-3'> Shipped Orders</h3>
      <table className='table table-striped custab'>
        <tr>
          <th>Name</th>
          <th>Email</th>
          <th>Phone</th>
          <th>Amount</th>
          <th>Address</th>
          <th>UUID</th>
          <th>Status</th>
          <th>Action</th>
          <th></th>
          <th></th>
          <th></th>
        </tr>
        <tbody>
          {
            shippedOrders.map(order => {
              return (
                <tr>
                  <td>{`${order.first_name} ${order.last_name}`}</td>
                  <td>{order.email}</td>
                  <td>{order.phone}</td>
                  <td>{order.amount}</td>
                  <td>{`${order.address1} ${order.address2}, ${order.city}, ${order.region} ${order.postal_code}`}</td>
                  <td>{order.uuid}</td>
                  <td>{order.shipped ? 'Shipped' : 'Not Shipped'}</td>
                  <td><a href="">Updated Status</a></td>
                  <td><a href={'/manage/orders/' + order.uuid}>Show</a></td>
                  <td><a href={'/manage/orders/' + order.uuid + '/edit'}>Edit</a></td>
                  <td><a href="">Destroy</a></td>
                </tr>
              )
            })
          }
        </tbody>
      </table>
    </div> 
  </div>
  )
};

export default Index;