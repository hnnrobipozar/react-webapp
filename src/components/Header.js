import React from "react";

import "./Header.css";

import Navigation from "./Navigation";

class Header extends React.Component {
  render() {
    return (
      <header className="top" style={{
        display: "flex",
        flexDirection: "column",
        alignItems: "center", 
      }}>
        <Navigation />
        <h1>Super hot</h1>
        <img src="/michalek.png" />
      </header>
    );
  }
}

export default Header;
