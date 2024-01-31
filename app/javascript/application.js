// Configure your import map in config/importmap.rb. Read more: https://github.com/rails/importmap-rails

import "bootstrap"
import "@popperjs/core"
import "@hotwired/turbo-rails"

window.onload = function () {
  const popoverTriggerList = document.querySelectorAll('[data-bs-toggle="popover"]')
  const popoverList = [...popoverTriggerList].map(d => new bootstrap.Popover(d))
  const tooltipTriggerList = document.querySelectorAll('[data-bs-toggle="tooltip"]')
  const tooltipList = [...tooltipTriggerList].map(d => new bootstrap.Tooltip(d))
}

import "controllers"
import "tasks"