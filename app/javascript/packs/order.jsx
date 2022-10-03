import React from 'react'
import ReactDOM from 'react-dom'
import PropTypes from 'prop-types'

const UnshippedOrders = props => (
  props.unshipped_orders
)

const ShippedOrders = props => (
  props.shipped_orders
)

Order.propTypes = {
  orders: PropTypes.object
}