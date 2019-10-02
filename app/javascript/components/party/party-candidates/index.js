import React, { PureComponent } from "react";
import Layout from 'antd/es/layout';
import LayoutHeader from "../../common/LayoutHeader";
import LayoutFooter from "../../common/LayoutFooter";
import PartyHeader from "../PartyHeader";
import PartyIntro from "../PartyIntro";
import PartyCandidatesTable from "./PartyCandidatesTable";
import { Typography } from "antd";

const { Paragraph } = Typography;

class PartyCandidate extends PureComponent {
    constructor() {
        super();

        this.state = {
            party: {
                leadCandidate: {}
            },
        }
    }

    componentDidMount() {
        fetch("/parties/" + this.props.match.params.party_acronym + "/candidates/" + this.props.match.params.district + ".json")
            .then(res => res.json())
            .then(data => {
                this.setState({
                    party: data
                })
            })
            .catch((error) => {
                console.log(error);
            });
    }

    render() {
        const { party } = this.state;
        const hasBiography = party.leadCandidate.biography_source;
        const hasParliament = party.leadCandidate.link_parlamento;
        return (
            <Layout>
                <LayoutHeader />
                <Layout.Content>
                    <PartyHeader party={party} subtitle={`${party.acronym} - Círculo eleitoral de ${this.props.match.params.district}`} />
                    <PartyIntro spokesperson={party.leadCandidate} title={party.leadCandidate.name}>
                        <Paragraph className="party-desc">{party.leadCandidate.biography}</Paragraph>
                        {hasBiography && (
                        <Paragraph>Biografia: <a href={party.leadCandidate.biography_source} target="_blank" rel="noopener">aqui</a></Paragraph>
                        )}
                        {hasParliament && (
                        <Paragraph>Página do Parlamento: <a href={party.leadCandidate.link_parlamento} target="_blank" rel="noopener">aqui</a></Paragraph>
                        )}
                        </PartyIntro>
                    {party.candidates && (
                        <PartyCandidatesTable candidates={party.candidates} />
                    )}
                </Layout.Content>
                <LayoutFooter />
            </Layout>
        );
        
    }
}

export default PartyCandidate;
