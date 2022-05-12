import { Controller } from "@hotwired/stimulus";

export default class extends Controller {
  connect() {}

  toggleForm(e) {
    e.preventDefault();
    e.stopPropagation();

    const form = document.getElementById(e.params["form"]);
    form.classList.toggle("hidden");

    if (!form.classList.contains("hidden")) {
      const input = form.querySelector("#comment_content");
      input.focus();
    }
  }
}
